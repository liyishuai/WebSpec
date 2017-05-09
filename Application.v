Require Import FileSystem.
Require Import HttpPrimitive.

Module Type Application (FS : FileSystem) (Prim : HttpPrimitive).
  Import FS.
  Import Prim.

  Parameter empty : entity.
  Parameter file_content : list bool -> entity.

  Parameter application_state : Type.
  Parameter fs : application_state -> file_system.
  Parameter map: application_state -> URI -> option path.

  Definition App A := application_state -> (A * application_state).

  Parameter execute : HttpPrimitive -> App HttpResponse.

  Axiom get_spec : forall uri app status entity app',
      execute (Prim_Get uri) app = (Response status entity, app') ->
      (* GET does not modify mapping *)
      map app' = map app /\
      (* URI found in mapping *)
      (forall p, map app uri = Some p ->
       (* path found in file system *)
       (forall bs, contents (fs app) p = Some bs ->
                   status = Status_OK /\ 
                   entity = file_content bs) /\
       (* path not found in file system *)
       (contents (fs app) p = None ->
        status = Status_NotFound /\
        entity = empty)) /\
      (* URI not found in mapping *)
      (map app uri = None ->
       status = Status_NotFound /\
       entity = empty).

  Axiom put_spec : forall bs uri app status entity' app',
      let entity := file_content bs in
      execute (Prim_Put uri entity) app = (Response status entity', app') ->
      status = Status_OK /\
      (* URI is bound to some resource *)
      (exists p,
          map app' uri = Some p /\
          contents (fs app') p = Some bs) /\
      (* other URI' remain unchanged *)
      forall uri',
        map app  uri' <> map app uri ->
        map app' uri' = map app uri'.

End Application.

Require Import FileSystem.
Require Import HttpPrimitive.

Module Type Application (FS : FileSystem) (Prim : HttpPrimitive).
  Import FS.
  Import Prim.

  Parameter empty : entity.
  Parameter file_content : list bool -> entity.

  Record abstract_application :=
    abs { fs  : abstract_file_system;
          map : URI -> option path
        }.

  Definition App A := abstract_application -> (A * abstract_application).

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

End Application.

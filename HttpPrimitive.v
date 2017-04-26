Module Type HttpPrimitive.

  Parameter URI    : Type.
  Parameter entity : Type.

  Inductive HttpPrimitive :=
    Prim_Get    : URI -> HttpPrimitive
  | Prim_Head   : URI -> HttpPrimitive
  | Prim_Post   : URI -> entity -> HttpPrimitive
  | Prim_Put    : URI -> entity -> HttpPrimitive
  | Prim_Delete : URI -> HttpPrimitive.

  Inductive HttpStatus :=
    Status_OK : HttpStatus
  | Status_NotFound : HttpStatus
  | Status_NotImplemented : HttpStatus.

  Inductive HttpResponse :=
    Response : HttpStatus -> entity -> HttpResponse.

End HttpPrimitive.
Module Type HttpPrimitive.

  Parameter URI    : Type.
  Parameter entity : Type.

  Inductive HttpPrimitive :=
    Prim_Get    : URI -> HttpPrimitive
  | Prim_Head   : URI -> HttpPrimitive
  | Prim_Post   : URI -> entity -> HttpPrimitive
  | Prim_Put    : URI -> entity -> HttpPrimitive
  | Prim_Delete : URI -> HttpPrimitive.

End HttpPrimitive.
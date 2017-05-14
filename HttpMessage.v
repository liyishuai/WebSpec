Module Type HttpMessage.

  (* https://tools.ietf.org/html/rfc2616#section-3.1 *)
  Parameter HttpVersion : Type.

  (* https://tools.ietf.org/html/rfc2616#section-3.2 *)
  Parameter URI : Type.

  (* https://tools.ietf.org/html/rfc2616#section-5.1.1 *)
  (* https://tools.ietf.org/html/rfc2616#section-9 *)
  Inductive HttpMethod :=
  | Method_Get    : HttpMethod
  | Method_Head   : HttpMethod
  | Method_Post   : HttpMethod
  | Method_Put    : HttpMethod
  | Method_Delete : HttpMethod.

  (* https://tools.ietf.org/html/rfc2616#section-6.1.1 *)
  (* https://tools.ietf.org/html/rfc2616#section-10 *)
  Inductive HttpStatus :=
  (* https://tools.ietf.org/html/rfc2616#section-10.2.1 *)
    Status_OK : HttpStatus
  (* https://tools.ietf.org/html/rfc2616#section-10.4.5 *)
  (* https://tools.ietf.org/html/rfc7231#section-6.5.4 *)
  | Status_NotFound : HttpStatus
  (* https://tools.ietf.org/html/rfc2616#section-10.5.2 *)
  (* https://tools.ietf.org/html/rfc7231#section-6.6.2 *)
  | Status_NotImplemented : HttpStatus
  (* https://tools.ietf.org/html/rfc2616#section-10.4.1 *)
  (* https://tools.ietf.org/html/rfc7231#section-6.5.1 *)
  | Status_BadRequest : HttpStatus
  (* https://tools.ietf.org/html/rfc2616#section-10.4.2 *)
  | Status_Unauthorized : HttpStatus.
  
  (* https://tools.ietf.org/html/rfc2616#section-5.1 *)
  Inductive HttpRequestLine :=
    RequestLine : HttpMethod -> URI -> HttpVersion -> HttpRequestLine.

  (* https://tools.ietf.org/html/rfc2616#section-6.1 *)
  Inductive HttpStatusLine :=
    StatusLine : HttpVersion -> HttpStatus -> HttpStatusLine.
  
  (* https://tools.ietf.org/html/rfc2616#section-4.5 *)
  Parameter HttpGeneralHeader : Type.
  
  (* https://tools.ietf.org/html/rfc2616#section-5.3 *)
  Parameter HttpRequestHeader : Type.

  (* https://tools.ietf.org/html/rfc2616#section-6.2 *)
  Parameter HttpResponseHeader : Type.
  
  (* https://tools.ietf.org/html/rfc2616#section-7.1 *)
  Parameter HttpEntityHeader : Type.

  (* https://tools.ietf.org/html/rfc2616#section-7.2 *)
  Parameter HttpEntityBody : Type.

  Parameter HttpRequestHeaderList : HttpRequestLine -> HttpEntityBody -> Type.
  
  Parameter HttpResponseHeaderList : HttpStatusLine -> HttpEntityBody -> Type.

  (* https://tools.ietf.org/html/rfc2616#section-5 *)
  Inductive HttpRequest :=
    Request : forall requestLine entityBody,
      HttpRequestHeaderList requestLine entityBody -> HttpRequest.

  (* https://tools.ietf.org/html/rfc2616#section-6 *)
  Inductive HttpResponse :=
    Response : forall statusLine entityBody,
      HttpResponseHeaderList statusLine entityBody -> HttpResponse.
  
End HttpMessage.
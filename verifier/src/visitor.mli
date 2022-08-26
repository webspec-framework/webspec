module type Visitor =
sig
  type t
  val request_handler :  t -> Model.Browser.coq_Emitter -> Model.Browser.coq_Request -> int -> Types.State.t option -> t
  val response_handler : t -> Model.Browser.coq_Response -> int -> t
  val url_source_handler : t -> Model.Browser.coq_URL -> Model.Browser.coq_HTMLElement option -> t 
  val url_handler : t -> Model.Browser.coq_URL -> t
  val domupdate_handler : t -> Types.NestedDOMPath.t -> t 
  val default_handler : t -> Model.Browser.coq_Event -> t
  val handle : t -> (Types.Event.t * Types.State.t option) -> t
end

module Preprocessor : Visitor with type t = States.VerifierState.t
module ResponseGenerator : Visitor with type t = States.VerifierState.t

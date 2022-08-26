
module type S =
sig
  val s_response : States.VerifierState.t -> int -> string
  val s_request : States.VerifierState.t -> int -> string
  (* RoundTrip-related functions*)
end

module ServiceWorker : S 

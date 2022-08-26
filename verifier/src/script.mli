
module type S =
sig
  (* RoundTrip-related functions*)
  val generate_scripts : States.VerifierState.t -> States.VerifierState.t
  val generate_sw : States.VerifierState.t -> States.sw_t -> string
end



module Script : S 
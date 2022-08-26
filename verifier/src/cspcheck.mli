
module type S =
sig
  val generate_assertions : States.VerifierState.t -> States.VerifierState.t 
  val generate_checks : States.VerifierState.t -> States.VerifierState.t
end



module CSPChecker : S 
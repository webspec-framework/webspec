module type S =
sig
  type t

  val html_to_string : t -> Types.HTML.t -> string list option -> string
end

module Translator : S with type t = States.VerifierState.t

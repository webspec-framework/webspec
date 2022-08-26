
module type S =
sig
  val gen_uuid : unit -> string
end


module Generator : S 
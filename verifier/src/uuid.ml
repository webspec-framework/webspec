module type S =
sig
  val gen_uuid : unit -> string
end


module Generator : S = 
struct
  let gen_uuid () : string = 
    let rst = Random.State.make_self_init () in
    Uuidm.v4_gen rst () 
    |> Uuidm.to_string

end

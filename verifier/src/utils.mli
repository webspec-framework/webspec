val port_from_protocol : Types.Protocol.t -> int
val print_int_map : int -> Types.Int.Set.t -> unit
val print_set : Types.Int.Set.t -> string
val print_origin_set : Types.Origin.Set.t -> unit
val print_url_set : Types.URL.Set.t -> unit
val print_url_map : 
  Types.URL.t -> Types.URL.t -> unit

val write_to_file : string -> string -> unit

val event_state_pairs : Types.Event.t list -> Types.State.t list -> (Types.Event.t * Types.State.t option) list

val rand_chr : unit -> char 
val rand_str : int -> string 
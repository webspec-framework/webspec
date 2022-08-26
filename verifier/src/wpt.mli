
module type S =
sig
  type t 

  val empty : t
  val to_yojson : t -> Yojson.Safe.t
  val state_to_config : States.VerifierState.t -> t 
  

end

type config = {
  ports : Types.Int.Set.t Types.Protocol.Map.t ;
  browser_host : Types.Domain.t;
  alternate_hosts : Types.Int.Set.t; 
  subdomains : Types.Int.Set.t;
}

module Config : S with type t = config 

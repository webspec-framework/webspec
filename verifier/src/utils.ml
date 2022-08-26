let port_from_protocol (proto : Types.Protocol.t) : int = 
  match proto with 
  | ProtocolHTTP -> 8080
  | ProtocolHTTPS ->  8443
  | ProtocolData -> 8080 (* idk about these *)
  | ProtocolBlob -> 8080 (* idk about these *)


let print_set (s : Types.Int.Set.t ) : string =
  Printf.sprintf "{ %s }" (String.concat "; " (List.map string_of_int (Types.Int.Set.elements s)))  

let print_int_map (domain : int) (subdomain : Types.Int.Set.t) : unit = 
  print_string (String.concat ":" [string_of_int domain; "\n"]) ;
  ignore (print_set subdomain)

let print_origin_set (s : Types.Origin.Set.t ) : unit = 
  print_string "Origins -> {" ; 
  Types.Origin.Set.iter (fun x -> print_string (" " ^ Types.Origin.show x ^ " ")) s ;
  print_string "}\n" 

let print_url_set (s : Types.URL.Set.t ) : unit = 
  print_string "URLs -> {" ; 
  Types.URL.Set.iter (fun x -> print_string (" " ^ Types.URL.show x ^ " ")) s ;
  print_string "}\n" 

let print_url_map (url : Types.URL.t) (dummy : Types.URL.t) : unit = 
  print_string (String.concat ":" [Types.URL.show url; " -> "; Types.URL.show dummy ])

let write_to_file (filename : string) (content : string) : unit = 
  let oc = open_out filename in 

  Printf.fprintf oc "%s" content ; 

  close_out oc

let rec extend_list (idx : int) (sz : int) (acc : 'a option list) (ref : 'a list) : 'a option list = 
  if idx < sz then
    let acc = acc @ [List.nth_opt ref idx] in
    extend_list (idx+1) sz acc ref
  else 
    acc

let event_state_pairs (ev : Types.Event.t list) (st : Types.State.t list) : (Types.Event.t * Types.State.t option) list = 
  let st_rev = List.rev st in 

  let new_st_rev = extend_list 0 (List.length ev) [] st_rev in
  let new_st = List.rev new_st_rev in 

  List.fold_left2 (fun acc el1 el2 -> acc @ [(el1, el2)]) [] ev new_st
  

let rand_chr () : char = 
  Char.chr (97 + (Random.int 26))

let rand_str (sz : int) : string = 
  String.init sz (fun _ -> rand_chr ()) 

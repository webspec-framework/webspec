(* ACTIONS *)
(* Request emitters *)

module type S =
sig 
  type t

  val translate : States.VerifierState.t -> unit

end

type fetchCreds = 
| Omit
| SameOrigin
| Include 

type fetchRedirect = 
| Follow
| Error
| Manual

type fetchCache = 
| Default
| NoStore
| Reload
| NoCache
| ForceCache
| OnlyIfCached

type fetchReferrer =
| URL of Types.URL.t
| AboutClient
| Empty

type fetchMode = 
| Cors
| NoCors
| SameOrigin

type fetchMethod = 
| MethodGet
| MethodPost
| MethodPut
| MethodDelete
| MethodOptions

type fetchReferrerPolicy = 
| NoReferrer
| NoReferrerWhenDowngrade
| SameOrigin
| Origin
| StrictOrigin
| OriginWhenCrossOrigin
| StrictOriginWhenCrossOrigin
| UnsafeURL

type fetchInit = {
  f_method : Types.String.t option ;
  f_headers : Types.String.t Types.String.Map.t option;
  f_body : Types.String.t option ; (* is this correct? *)
  f_mode : fetchMode option ;
  f_credentials : fetchCreds option ;
  f_cache : fetchCache option ; 
  f_redirect : fetchRedirect option ; 
  f_referrer : fetchReferrer option ; 
  f_referrer_policy : fetchReferrerPolicy option ;
  f_integrity : Types.String.t option ; 
  f_keepalive : bool option; (* true if present else false*)
  (* f_signal -> no support for now *)
}

type cookieAttribute =
| Path of Types.String.t
| Domain of Types.String.t
| MaxAge of Types.Int.t
| Expires of Types.String.t (*timestamp*)
| Secure
| SameSiteLax
| SameSiteStrict
| SameSiteNone

type cookiePrefix = 
| Secure
| Host

type action = 
| Implicit (* CORS pre-flight and resource loading *)
| WindowOpen of Types.URL.t * Types.String.t option (* (url, target) ; windowFeatures not supported by WebSpec *)
| UPDATE_HTML
| Fetch of Types.URL.t * fetchInit option (* fetch url, *) (* both for Script and Worker??*)
| Location of Types.NestedDOMPath.t
| FormSubmit of Types.String.t (* form ID *)
| JSSetItem of Types.NestedDOMPath.t * Types.String.t * Types.String.t (* window.loalStorage.setItem(k, v)*)
| JSCreateBlobURL of Types.NestedDOMPath.t * Types.URL.t
| JSPostMessage of Types.String.t * Types.Origin.t
| JSSetCookie of Types.String.t * Types.String.t * cookieAttribute option * cookiePrefix option(* document.cookie = newCookie*)
| JSUpdateCache(*caches.open() -> add / addAll*)
| JSDOmainRelaxation of Types.NestedDOMPath.t * Types.Domain.t 
| WorkerUpdateCache
| WorkerCacheMatch


type verification = 
| Implicit
| DomUpdate of Types.NestedDOMPath.t * Types.String.t (* target ; value *)
  | AssertEquals of Types.NestedDOMPath.t * Types.String.t

type setup = 
| Empty


type event = {e_setup : setup option ; e_action : action ; e_verification : verification}

type script = { s_script : Types.Script.t ; s_actions : action list }


type test = {
  t_events : event list ;
  t_launcher : Types.String.t ;
  t_asserts : Types.String.t ; 
  t_responses : Types.Response.t list;
  t_scripts : script list ;
}

module Wptest : S with type t = test = 
struct
  type t = test

  let produce_headers (headers : Types.ResponseHeaders.t) : Yojson.Safe.t = 
    Types.ResponseHeaders.to_yojson headers

  let produce_response (st : States.VerifierState.t) (response : Types.Response.t) : Types.Response.t =
    { response with rp_url=(States.VerifierState.translate_url st response.rp_url)}
    
    
  let translate (st : States.VerifierState.t) : unit = 
    print_endline "RESPONSES" ; 
    Types.Int.Map.iter (fun key r -> print_endline (Yojson.Safe.pretty_to_string (Types.Response.to_yojson (produce_response st r)))) st.responses


end

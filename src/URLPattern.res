@ocaml.doc("Represents the URLPattern instance.")
type t

@ocaml.doc("The init parameters that can be passed to the `make` function.")
type init

@obj
external init: (
  ~baseURL: string=?,
  ~username: string=?,
  ~password: string=?,
  ~protocol: string=?,
  ~hostname: string=?,
  ~port: string=?,
  ~pathname: string=?,
  ~search: string=?,
  ~hash: string=?,
  unit,
) => init = ""

@ocaml.doc("Makes an URLPattern from an `init` argument.")
@new
@module("urlpattern-polyfill/dist/index.umd.js")
external make: init => t = "URLPattern"

@ocaml.doc("Makes an URLPattern from an string an optional `baseUrl`.")
@new
@module("urlpattern-polyfill/dist/index.umd.js")
external fromString: (string, ~baseUrl: string=?, unit) => t = "URLPattern"

type componentResult = {
  input: string,
  groups: Js.Dict.t<string>,
}

@ocaml.doc("The value returned by the `exec` method.
The _ underscore prevents any name conflict with the standard lib `result` type.")
type result_ = {
  protocol: componentResult,
  username: componentResult,
  password: componentResult,
  hostname: componentResult,
  port: componentResult,
  pathname: componentResult,
  search: componentResult,
  hash: componentResult,
}

@ocaml.doc("Executes an URLPattern against a string and returns a `result_` object if they match.")
@return(nullable)
@send
external exec: (t, string) => option<result_> = "exec"

@ocaml.doc(
  "Executes an URLPattern against another URLPattern and returns a `result_` object if they match."
)
@return(nullable)
@send
external execWithURLPattern: (t, t) => option<result_> = "exec"

@ocaml.doc("Returns `true` if the provided string and the URLPattern match, `false` otherwise.")
@send
external test: (t, string) => bool = "test"

@ocaml.doc("Returns `true` if the provided URLPattern and the URLPattern match, `false` otherwise.")
@send
external testWithURLPattern: (t, string) => bool = "test"

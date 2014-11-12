%% @author Mochi Media <dev@mochimedia.com>
%% @copyright short_url Mochi Media <dev@mochimedia.com>

%% @doc Callbacks for the short_url application.

-module(short_url_app).
-author("Mochi Media <dev@mochimedia.com>").

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for short_url.
start(_Type, _StartArgs) ->
    short_url_deps:ensure(),
    short_url_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for short_url.
stop(_State) ->
    ok.

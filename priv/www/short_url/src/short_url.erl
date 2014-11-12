%% @author Mochi Media <dev@mochimedia.com>
%% @copyright 2010 Mochi Media <dev@mochimedia.com>

%% @doc short_url.

-module(short_url).
-author("Mochi Media <dev@mochimedia.com>").
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.


%% @spec start() -> ok
%% @doc Start the short_url server.
start() ->
    short_url_deps:ensure(),
    ensure_started(crypto),
    application:start(short_url).


%% @spec stop() -> ok
%% @doc Stop the short_url server.
stop() ->
    application:stop(short_url).

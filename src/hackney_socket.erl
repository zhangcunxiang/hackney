-module(hackney_socket).
-export([connect/3, connect/4,
         secure/2, secure/3,
         close/1,
         shutdown/2,
         send/2,
         recv/2, recv/3,
         setopts/2,
         controlling_process/2,
         peername/1,
         sockname/1]).

-include("hackney.hrl").

-type hsock() :: #hsock{}.

-export_types([hsock/0]).


connect(Address, Port, Options) -> connect(Address, Port, Options, infinity).

%% @doc Connects to a server on TCP port Port on the host with IP address Address.
%% The Address argument can be either a hostname, or an IP address.
-spec connect(Address, Port, Options, Timeout) -> {ok, HSock} | {error, Reason}
    when Address :: inet:ip_address() | inet:hostname(),
         Port :: inet:port_number(),
         Options :: [gen_tcp:connect_option()],
         Timeout :: timeout(),
         HSock :: hsock(),
         Reason :: inet:posix().
connect(Address, Port, Options, Timeout) ->
    case gen_tcp:connect(Address, Port, Options, Timeout) of
        {ok, Sock} -> {ok, #hsock{mod=gen_tcp, sock=Sock}};
        Error -> Error
    end.

secure(HS, Options) -> secure(HS, Options, infinity).

%% @doc upgrade the socket to SSL
-spec secure(HSock, SSlOptions, Timeout) -> {ok, HSock2} | {error, Reason}
    when HSock :: hsock(),
         SSlOptions :: [ssl:ssloption()],
         Timeout :: timeout(),
         HSock2 :: hsock(),
         Reason :: term().
secure(#hsock{secure=true}=HS, _Options, _Timeout) ->
    {ok, HS};
secure(#hsock{mod=gen_tcp, sock=Sock}=HS, Options, Timeout) ->
    case ssl:connect(Sock, Options, Timeout) of
        {ok, SSlSock} -> {ok, HS#hsock{mod=ssl, sock=SSlSock, secure=true}};
        Error -> Error
    end;
secure(_, _, _) ->
    error(bad_socket).

%% @doc close the socket
-spec close(HSock) -> ok | {error, Reason}
    when HSock :: hsock(),
         Reason :: term().
close(#hsock{mod=Mod, sock=Sock}) -> Mod:close(Sock).

%% @doc close the socket
-spec shutdown(HSock, How) -> ok | {error, Reason}
    when HSock :: hsock(),
         How :: read | write | read_write,
         Reason :: term().
shutdown(#hsock{mod=Mod, sock=Sock}, How) -> Mod:shutdown(Sock, How).

%% @doc Sends a packet on a socket.
-spec send(HS, Data) -> ok | {error, Reason}
    when HS :: hsock(),
         Data :: string() | binary() | HttpPacket,
         Reason :: closed | inet:posix(),
         HttpPacket :: term().
send(#hsock{mod=Mod, sock=Sock}, Data) -> Mod:send(Sock, Data).

recv(HS, Len) -> recv(HS, Len, infinity).

%% @doc This function receives a packet from a socket in passive mode. A closed socket is indicated by a return value {error, closed}.
-spec recv(HSock, Len, Timeout) -> {ok, Data} | {error, Reason}
    when HSock :: hsock(),
         Len :: non_neg_integer(),
         Timeout :: timeout(),
         Data ::string() | binary() | HttpPacket,
         Reason :: closed | inet:posix(),
         HttpPacket :: term().
recv(#hsock{mod=Mod, sock=Sock}, Len, Timeout) -> Mod:recv(Sock, Len, Timeout).

%% @doc Sets options according to Options for socket Socket.
-spec setopts(HSock, Options) -> ok | {error, Reason}
    when HSock :: hsock(),
         Options :: [inet:socket_setopt()],
         Reason :: term().
setopts(#hsock{mod=gen_tcp, sock=Sock}, Opts) -> inets:setopts(Sock, Opts);
setopts(#hsock{mod=Mod, sock=Sock}, Opts) -> Mod:setopts(Sock, Opts).

%% @doc Assigns a new controlling process Pid to Socket.
-spec controlling_process(HSock, Pid) -> ok | {error, Reason}
    when HSock :: hsock(),
         Pid :: pid(),
         Reason :: term().
controlling_process(#hsock{mod=Mod, sock=Sock}, Pid) ->
    Mod:controlling_process(Sock, Pid).

%% @doc Returns the address and port for the other end of a connection.
-spec peername(HSock) -> {ok, {Address, Port}} | {error, hackney:posix()}
    when HSock :: hsock(),
         Address :: inet:ip_address(),
         Port :: non_neg_integer().
peername(#hsock{mod=gen_tcp, sock=Sock}) -> inets:peername(Sock);
peername(#hsock{mod=Mod, sock=Sock}) -> Mod:peername(Sock).

%% @doc Returns the local address and port number for a socket.
-spec sockname(HSock) -> {ok, {Address, Port}} | {error, hackney:posix()}
    when HSock :: hsock(),
         Address :: inet:ip_address(),
         Port :: non_neg_integer().
sockname(#hsock{mod=gen_tcp, sock=Sock}) -> inets:sockname(Sock);
sockname(#hsock{mod=Mod, sock=Sock}) -> Mod:sockname(Sock).



# Module hackney_socket #
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)

<a name="types"></a>

## Data Types ##




### <a name="type-hsock">hsock()</a> ###


<pre><code>
hsock() = #hsock{}
</code></pre>

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#close-1">close/1</a></td><td>close the socket.</td></tr><tr><td valign="top"><a href="#connect-3">connect/3</a></td><td></td></tr><tr><td valign="top"><a href="#connect-4">connect/4</a></td><td>Connects to a server on TCP port Port on the host with IP address Address.</td></tr><tr><td valign="top"><a href="#controlling_process-2">controlling_process/2</a></td><td>Assigns a new controlling process Pid to Socket.</td></tr><tr><td valign="top"><a href="#peername-1">peername/1</a></td><td>Returns the address and port for the other end of a connection.</td></tr><tr><td valign="top"><a href="#recv-2">recv/2</a></td><td></td></tr><tr><td valign="top"><a href="#recv-3">recv/3</a></td><td>This function receives a packet from a socket in passive mode.</td></tr><tr><td valign="top"><a href="#secure-2">secure/2</a></td><td></td></tr><tr><td valign="top"><a href="#secure-3">secure/3</a></td><td>upgrade the socket to SSL.</td></tr><tr><td valign="top"><a href="#send-2">send/2</a></td><td>Sends a packet on a socket.</td></tr><tr><td valign="top"><a href="#setopts-2">setopts/2</a></td><td>Sets options according to Options for socket Socket.</td></tr><tr><td valign="top"><a href="#shutdown-2">shutdown/2</a></td><td>close the socket.</td></tr><tr><td valign="top"><a href="#sockname-1">sockname/1</a></td><td>Returns the local address and port number for a socket.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="close-1"></a>

### close/1 ###

<pre><code>
close(HSock) -&gt; ok | {error, Reason}
</code></pre>

<ul class="definitions"><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>Reason = term()</code></li></ul>

close the socket

<a name="connect-3"></a>

### connect/3 ###

`connect(Address, Port, Options) -> any()`

<a name="connect-4"></a>

### connect/4 ###

<pre><code>
connect(Address, Port, Options, Timeout) -&gt; {ok, HSock} | {error, Reason}
</code></pre>

<ul class="definitions"><li><code>Address = <a href="inet.md#type-ip_address">inet:ip_address()</a> | <a href="inet.md#type-hostname">inet:hostname()</a></code></li><li><code>Port = <a href="inet.md#type-port_number">inet:port_number()</a></code></li><li><code>Options = [<a href="gen_tcp.md#type-connect_option">gen_tcp:connect_option()</a>]</code></li><li><code>Timeout = timeout()</code></li><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>Reason = <a href="inet.md#type-posix">inet:posix()</a></code></li></ul>

Connects to a server on TCP port Port on the host with IP address Address. The Address argument can be either a hostname, or an IP address.

<a name="controlling_process-2"></a>

### controlling_process/2 ###

<pre><code>
controlling_process(HSock, Pid) -&gt; ok | {error, Reason}
</code></pre>

<ul class="definitions"><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>Pid = pid()</code></li><li><code>Reason = term()</code></li></ul>

Assigns a new controlling process Pid to Socket.

<a name="peername-1"></a>

### peername/1 ###

<pre><code>
peername(HSock) -&gt; {ok, {Address, Port}} | {error, <a href="hackney.md#type-posix">hackney:posix()</a>}
</code></pre>

<ul class="definitions"><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>Address = <a href="inet.md#type-ip_address">inet:ip_address()</a></code></li><li><code>Port = non_neg_integer()</code></li></ul>

Returns the address and port for the other end of a connection.

<a name="recv-2"></a>

### recv/2 ###

`recv(HS, Len) -> any()`

<a name="recv-3"></a>

### recv/3 ###

<pre><code>
recv(HSock, Len, Timeout) -&gt; {ok, Data} | {error, Reason}
</code></pre>

<ul class="definitions"><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>Len = non_neg_integer()</code></li><li><code>Timeout = timeout()</code></li><li><code>Data = string() | binary() | HttpPacket</code></li><li><code>Reason = closed | <a href="inet.md#type-posix">inet:posix()</a></code></li><li><code>HttpPacket = term()</code></li></ul>

This function receives a packet from a socket in passive mode. A closed socket is indicated by a return value {error, closed}.

<a name="secure-2"></a>

### secure/2 ###

`secure(HS, Options) -> any()`

<a name="secure-3"></a>

### secure/3 ###

<pre><code>
secure(HSock, SSlOptions, Timeout) -&gt; {ok, HSock2} | {error, Reason}
</code></pre>

<ul class="definitions"><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>SSlOptions = [<a href="ssl.md#type-ssloption">ssl:ssloption()</a>]</code></li><li><code>Timeout = timeout()</code></li><li><code>HSock2 = <a href="#type-hsock">hsock()</a></code></li><li><code>Reason = term()</code></li></ul>

upgrade the socket to SSL

<a name="send-2"></a>

### send/2 ###

<pre><code>
send(HS, Data) -&gt; ok | {error, Reason}
</code></pre>

<ul class="definitions"><li><code>HS = <a href="#type-hsock">hsock()</a></code></li><li><code>Data = string() | binary() | HttpPacket</code></li><li><code>Reason = closed | <a href="inet.md#type-posix">inet:posix()</a></code></li><li><code>HttpPacket = term()</code></li></ul>

Sends a packet on a socket.

<a name="setopts-2"></a>

### setopts/2 ###

<pre><code>
setopts(HSock, Options) -&gt; ok | {error, Reason}
</code></pre>

<ul class="definitions"><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>Options = [<a href="inet.md#type-socket_setopt">inet:socket_setopt()</a>]</code></li><li><code>Reason = term()</code></li></ul>

Sets options according to Options for socket Socket.

<a name="shutdown-2"></a>

### shutdown/2 ###

<pre><code>
shutdown(HSock, How) -&gt; ok | {error, Reason}
</code></pre>

<ul class="definitions"><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>How = read | write | read_write</code></li><li><code>Reason = term()</code></li></ul>

close the socket

<a name="sockname-1"></a>

### sockname/1 ###

<pre><code>
sockname(HSock) -&gt; {ok, {Address, Port}} | {error, <a href="hackney.md#type-posix">hackney:posix()</a>}
</code></pre>

<ul class="definitions"><li><code>HSock = <a href="#type-hsock">hsock()</a></code></li><li><code>Address = <a href="inet.md#type-ip_address">inet:ip_address()</a></code></li><li><code>Port = non_neg_integer()</code></li></ul>

Returns the local address and port number for a socket.


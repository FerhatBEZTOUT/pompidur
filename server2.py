import socket               # Import socket module

soc = socket.socket()         # Create a socket object
host = "localhost" # Get local machine name
port = 2005                # Reserve a port for your service.
soc.bind((host, port))       # Bind to the port
soc.listen(5)                 # Now wait for client connection.
while True:
	conn, addr = soc.accept()     # Establish connection with client.
	print ("Got connection from",addr)
	msg = conn.recv(1024)
	msg = msg.decode('utf-8')
	msg = msg.strip()
	print (msg)
	print("longueur : "+str(len(msg)))
	if ( msg == 'Hello'):
		print("Hii everyone")
		conn.send("Hello Client!\n".encode())
		conn.send("Lol\n".encode())
		
	else:
		print("Go away")
	conn.close()

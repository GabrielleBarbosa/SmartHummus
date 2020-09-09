# import socket
# import sys

# # Significa que é possível receber conexões fora da rede local
# host = '192.168.137.1'

# port = 80

# # Cria um socket TCP/IP
# s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# #garante que o socket será destruído (pode ser reusado) após uma interrupção da execução 
# s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    
# # associa o socket a porta
# s.bind((host, port))

# print('Server %s on port %s' % (socket.gethostname(), port))


# # Enfileira uma nova conexão,  (define o modo servidor)
# s.listen(1)

# while True:
#     # Espera por novas conexões
#     print('waiting for a connection')
    
#     # Aceita conexões
#     conn, address = s.accept()
    
#     try:
#         print('Connected to %s on port %s ' % (client_address))
        
#         while True:
#             data = conn.recv(1024)
            
#             reply = 'OK...' + data            
#             if not data:
#                 break
                
#             conn.sendall(reply)
            
#     finally:
#         # Clean up the connection
#         conn.close()

import socket
import sys
from _thread import *
 
host = '192.168.137.1'   
port = 1234
 
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
 
#garante que o socket será destruído (pode ser reusado) após uma interrupção da execução 
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
 
#Bind socket to local host and port
try:
    s.bind((host, port))
except socket.error as msg:
    print ('Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1])
    sys.exit()
      
s.listen(1)
 
#Função para lidar com cada conexão (cliente)
def clientthread(conn):
    #Sai do loop quando o cliente desconecta, pois a variável data não conterá
    #nenhum conteúdo
    while True:
         
        #Receiving from client
        data = conn.recv(1024)
        reply = 'OK...' + data
        
        if not data: 
            break
     
        conn.sendall(reply)
     
    #destroi o socket e encerra thread ao sair do loop
    conn.close()
 
#Continua recebendo conexões
while True:
    #Aceita conexões
    conn, addr = s.accept()
    
    print ('Connected with ' + addr[0] + ':' + str(addr[1]))
     
    #Cria nova thread para uma nova conexão. O primeiro
    #argumento é o nome da função, e o segundo é uma tupla
    #com os parâmetros da função.
    start_new_thread(clientthread ,(conn,))
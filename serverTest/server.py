import socket

#teste1: 192.168.137.1
#teste2: 192.168.56.1
#teste3: 10.0.0.100

HOST = '192.168.137.1' # endereço do servidor 
PORT =  80             # porta desejada

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s: # "cria o socket"
    s.bind((HOST,PORT))                             # coloca o endereço IP e porta no socket
    s.listen(1)                                     # coloca o socket em modo passivo (ouvindo)
    while True:
        conn, addr = s.accept()                     # aceita uma nova conexão
        while True:                                 # permanece no loop(while) enquanto tiver dados para enviar/receber
            data = conn.recv(1024)                  # recebe os dados

            if not data:
                break                               # sai, pois não recebeu mais dados (acabou a comunicação)

            print(data.decode())                    # mostra a mensagem recebida
            sendData = data + '\nrecebido'.encode() # mensagem de resposta e confirmação
            conn.sendall(sendData)                  # envia a mensagem confirmando que recebeu algo
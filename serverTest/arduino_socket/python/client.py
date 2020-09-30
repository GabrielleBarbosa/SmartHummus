# ********************************************
# Autor: Fernando Krein Pinheiro
# Data: 12/05/2012
# Linguagem: Python
# ========= IMPORTANTE ===========
# O código esta livre para usar,
# citar e compartilhar desde que
# mantida sua fonte e seu autor.
# Obrigado.
#
# Código fonte baseado nos originais
# de Marcio Minicz encontrado em:
# http://www.python.org.br/wiki/SocketBasico
#
#********************************************
 
import socket
import os
import serial
 
HOST = '10.0.0.112'
PORTA = 80
 
tcpSOCKET = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
destinoCONEXAO = (HOST, PORTA)
tcpSOCKET.connect(destinoCONEXAO)
 
# os.system("clear")
print ("|====================================|")
print ("|    Arduino na rede usando Python   |")
print ("|====================================|")
print ("| Digite SAIR para teminar a conexao |")
 
dados = input()
 
while dados != 'SAIR':
    tcpSOCKET.send (dados)
    dados = input()
    print(dados)
tcpSOCKET.close()
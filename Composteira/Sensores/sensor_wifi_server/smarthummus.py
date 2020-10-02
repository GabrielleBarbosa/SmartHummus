# multicast e http - 
# simulação de um hardware para o alexa
# simula um produto da wemo (no caso tomada liga e desliga.)
import struct
import socket
import sys 
import _thread
import xml.etree.ElementTree as ET


def get_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # doesn't even have to be reachable
        s.connect(('10.255.255.255', 1))
        IP = s.getsockname()[0]
    except:
        IP = '127.0.0.1'
    finally:
        s.close()
    return IP


message = 'projeto alexa python 1'

https = get_ip()
hport = 8080


resp = (
 'HTTP/1.1 200 OK\r\n'
 'CACHE-CONTROL: max-age=86400\r\n'
 'DATE: Tue, 14 Dec 2016 02:30:00 GMT\r\n'
 'EXT:\r\n'
 'LOCATION: http://' + get_ip() + ':8080/setup.xml\r\n'
 'OPT: \"http://schemas.upnp.org/upnp/1/0/\"; ns=01\r\n'
 '01-NLS: b9200ebb-736d-4b93-bf03-835149d13983\r\n'
 'SERVER: Unspecified, UPnP/1.0, Unspecified\r\n'
 'X-User-Agent: redsonic'
 'ST: urn:Belkin:device:**\r\n'
 '\r\n\r\n')


def sendXML(msg):
   resp = ('HTTP/1.1 200 OK\r\n'
           'Content-Type: text/xml\r\n'
           'Connection: close\r\n'  
           '\r\n' + msg)
   return resp 

def sendHTTP(msg):
   resp = ('HTTP/1.1 200 OK\r\n'
           'Content-Type: text/html\r\n'
           'Connection: close\r\n'  
           '\r\n' 
           '\r\n' + msg + '\r\n\r\n')
   return resp 


def on_new_client(clientesocket, addr):
    while True:
        msg = clientesocket.recv(1024)
        if msg:
            print (str(addr) + ' >>' + msg.decode() )
            break
        else:
            break

    msg1 = msg.decode()
    

    if msg1.__contains__('/rest1.php'):
        print('achou')
        msg = ('HTTP/1.1 200 OK\r\n'
          'Content-Type: application/json\r\n'
          'Connection: close\r\n'  
          '\r\n'
          '\r\n'
          '{\"Name\":\"Nachiket Panchal\",'
          '\"Link\":\"errorsea.com\",'
          '\"data\":{\"Key1\":\"Value1\",\"Key2\":\"Value2\",\"Key3\":\"Value3\"}}'
          '\r\n')
        clientesocket.send(msg.encode())
    else:
                    msg = ('HTTP/1.1 404 Not Found\r\n'
                    'Date: Sun, 18 Oct 2009 10:36:20 GMT\r\n'
                    'Server: Wemo\r\n'
                    'Content-Type: text/html; charset=iso-8859-1\r\n'
                    'Connection: close\r\n'  
                    '\r\n'
                    '\r\n'
                    '<!DOCTYPE HTML>\r\n'
                    '<html><head><title>404 Not Found</title></head><body>\r\n'
                    '<h1>Not Found</h1><p>The requested URL /t.html was not found on this server.</p></body>\r\n'
                    '</html>\r\n')
                    clientesocket.send(msg.encode())


    clientesocket.close()




##

sockH = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    sockH.bind((https,hport))
except socket.error:
    sockH.bind(('', hport))

sockH.listen(1)

print('Listiong HTTP on '+https+' port : '+ str(hport)+ '\n')

while True:
    c, addr = sockH.accept()
    _thread.start_new_thread(on_new_client,(c,addr))
    
sockH.close()    

    
 

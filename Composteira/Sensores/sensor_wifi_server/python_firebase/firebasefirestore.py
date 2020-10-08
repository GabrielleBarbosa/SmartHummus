import firebase_admin
from firebase_admin import credentials
from firebase_admin import auth
from firebase_admin import firestore

cred = credentials.Certificate('firebase-sdk.json')
firebase_admin.initialize_app(cred)

'''
db = firestore.client()

doc_ref = db.collection('users')

doc_ref.add({
    'nome' : 'Maria',
    'sobrenome' : 'Silva'
})
'''

email = "cc18183@g.unicamp.br"
uid = "X2wY40NBg6VB6UMLARIiezxJmbT2"
user = auth.get_user_by_email(email)
if user.uid == uid:
    print("é igual")
    db = firestore.client()

    doc_ref = db.collection('medidas')

    doc_ref.add({
        'temperatura1':30,
        'temperatura2':29,
        'umidade1':22,
        'umidade2':60,
        'cheio': False,
        'gasMQ2': 89,
        'gasMQ135':890,
        'uid' : user.uid
    })
else:
    print("não é igual")

print("user {0}".format(user.uid))
from crypt import methods
import subprocess
import sys
import typing as t
import json

from datetime import datetime
from flask import Flask, jsonify, url_for, request, redirect

LISTENING_PORT = int(sys.argv[1])
FORMATO = sys.argv[2]
app = Flask(__name__)
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True
app.config['JSON_SORT_KEYS'] = False

def get_expiry(account):
  try:
    chage = subprocess.Popen(('chage', '-l', account), stdout=subprocess.PIPE)
    grep = subprocess.Popen(('grep', 'Account expires'), stdin=chage.stdout, stdout=subprocess.PIPE)
    cut = subprocess.Popen('cut -d : -f2'.split(), stdin=grep.stdout, stdout=subprocess.PIPE)
    output = cut.communicate()[0].strip()
    output = output.decode("utf-8")
    return output if output != 'never' else None
  except subprocess.CalledProcessError as e:
    return None

def get_format(username):
    if FORMATO == '1':
        date = datetime.strptime(username, '%b %d, %Y')
        format_date = datetime.strftime(date, '%Y%m%d')
        return format_date
    elif FORMATO == '2':
        date = datetime.strptime(username, '%b %d, %Y')
        format_date = datetime.strftime(date, '%d%m%Y')
        return format_date

@app.route('/checkUser',methods = ['POST', 'GET'])
def check_user():
    if request.method == 'POST':
        try:
            req_data = request.get_json()
            user = req_data.get("user")
            strDate = get_expiry(user)
            x = get_format(strDate)
            return x
        except Exception as e:
            return jsonify({'error': str(e)})
    else:
        try:
            return 'Cannot GET /checkUser'
        except Exception as e:
            return jsonify({'error': str(e)})


if __name__ == '__main__':
    app.run(
        host='0.0.0.0',
        port=int(sys.argv[1]) if len(sys.argv) > 1 else LISTENING_PORT,
    )

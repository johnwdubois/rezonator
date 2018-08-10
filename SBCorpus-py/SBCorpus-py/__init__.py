#!/usr/bin/python3

from __future__ import print_function
import sys
import os

def getinfo(line,cue,skip=2,endcue='"'):
  totallen = len(line)
  cue1 = 0
  cue2 = len(cue)
  cue3 = cue2+len(endcue)
  while line[cue1:cue2] != cue:
    cue1+=1
    cue2+=1
    cue3+=1
  cue2+=skip
  cue3+=skip
  info=''
  while line[cue2:cue3]!=endcue:
    info=info+line[cue2]
    cue2+=1
    cue3+=1
  return info

def xmlreader(fileids='ALL'):
  corpus={}
  if fileids=='ALL':
    for i in range(1,61):
      j=str(i)
      if len(j)==1:
        j='0'+j
      if sys.platform == 'win32':
        if sys.version_info[0:2] == (3, 4):
          text='C:\\Python34\\Lib\\site-packages\\SBCorpus\\'+'.sbc0'+j+'.xml'
        else:
          text='C:\\Python\\Lib\\site-packages\\SBCorpus\\'+'.sbc0'+j+'.xml'
      else:
        text=os.getcwd() + '/SBCorpus/.sbc0'+j+'.xml'
      text = open(text,'r')
      text = text.read()
      name = int(getinfo(text,'Media="SBC',0))
      print(str(name)+'/60 texts loaded                                   ', end='\r')
      corpus[name]={'name':getinfo(text,'Corpus="',0)}
      IUs = text.split('  <u')[1:]
      for IU in IUs:
        tID = int(getinfo(IU, 'tID="', 0))
        uID = int(getinfo(IU, 'uID="u', 0))
        PID = int(getinfo(IU, 'PID="', 0))
        trystart = getinfo(IU, 'start="', 0)
        start = ''
        for char in trystart:
          if char in '1234567890.':
            start +=char
        start = float(start)
        end = float(getinfo(IU, 'end="', 0))
        words=[]
        if '<g>' in IU:
          words = IU.split('<g>')[1:]
        unit={}
        w=1
        for word in words:
          main = ''
          if '<w>' in word:
            main = getinfo(word, '<w>', 0, '</w>')
          dt = ''
          if '<ga type="dt">' in word:
            dt = getinfo(word, '<ga type="dt">', 0, '</ga>')
          manner = []
          if '<ga type="manner">' in word:
            manners = getinfo(word, '<ga type="manner">', 0, '</g>').split('<ga type="manner"')[1:]
            for m in manners:
              manner += [getinfo(m, '>', 0, '<')]
          POS = ''
          if '<ga type="POS">' in word:
            POS = getinfo(word, '<ga type="POS">', 0, '</ga>')
          unit[w]={'word':main,'dt':dt,'manner':manner,'POS':POS}
          w+=1
        unit['start'] = start
        unit['end'] = end
        if tID not in corpus[name]:
          corpus[name][tID]={'ID':PID}
        corpus[name][tID][uID]=unit
  print(end='\n')
  print('done.')
  return corpus
  
corpus=xmlreader()

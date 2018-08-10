#!/usr/bin/python3

#from __future__ import print_function

#from xml import *
import SBCorpus
from SBCorpus.metadata import metadata

import re

class SBCorpusReader():
    def __init__(self):
        #self.corpus = SBCorpus.xmlreader()     
        self.corpus = SBCorpus.corpus   
        
        self.positions={
        'ID':0,
        'NAME':1,
        'GENDER':2,
        'AGE':3,
        'HOMETOWN':4,
        'HOMESTATE':5,
        'CURRENTSTATE':6,
        'EDUCATION':7,
        'YEARSEDUCATION':8,
        'OCCUPATION':9,
        'ETHNICITY':10,
        'TEXTS':11
        }
    
    def copy_object(self, obj):
        if type(obj) in (str,int,float):
            output=obj
        elif type(obj)==list:
            output=[]
            for item in obj:
                output+=[self.copy_object(item)]
        elif type(obj)==tuple:
            output=[]
            for item in obj:
                output+=[self.copy_object(item)]
            output=tuple(output)
        elif type(obj)==dict:
            output={}
            for key in list(obj):
                output[key]=self.copy_object(obj[key])
        return output
        
    def copy_part(self, output, source, text=None, turn=None, IU=None, word=None, tiers=None):
        if text != None:
            if turn != None:
                if text not in output:
                    output[text] = {'name':source[text]['name']}
                if IU != None:
                    if turn not in output[text]:
                        output[text][turn] = {'ID':source[text][turn]['ID']}
                    if word != None:
                        if IU not in output[text][turn]:
                            output[text][turn][IU] = {'start':source[text][turn][IU]['start'], 'end':source[text][turn][IU]['end']}
                        if tiers != None:
                            if word not in output[text][turn][IU]:
                                output[text][turn][IU][word] = {}
                            for tier in tiers:
                                if word not in output[text][turn][IU][word]:
                                    output[text][turn][IU][word][tier] = self.copy_object(source[text][turn][IU][word][tier])
                        elif tiers == None:
                            output[text][turn][IU][word] = self.copy_object(source[text][turn][IU][word])
                    elif word == None:
                        output[text][turn][IU] = self.copy_object(source[text][turn][IU])
                elif IU == None:
                    output[text][turn] = self.copy_object(source[text][turn])
            elif turn == None:
                output[text] = self.copy_object(source[text])
        elif text == None:
            output = self.copy_object(source)
        return output
    
    def get_range(self, terms):
        if ':' in terms:
            nrange=[]
            for i in range(int(terms.split(':')[0]),int(terms.split(':')[1])+1):
                nrange.append(i)
            terms = nrange
        else:
            if re.match('^\d*$', terms) == None:
                terms = [terms]
            else:
                terms = [int(terms)]
        return terms
    
    def get_parameters(self, identifier, negative=False, capsearch=True):
        identifiers = {}
        remove = {}
        if type(identifier) in [list,tuple]:
            return identifier
        elif type(identifier) in [int, float]:
            return [identifier]
        if ',' in identifier:
            identifier = identifier.split(',')
        elif type(identifier) == str:
            identifier = [identifier]
        for parameter in identifier:
            if '!=' in parameter:
                search,terms = parameter.split('!=')
                if capsearch == True:
                    search = search.upper()
                terms = self.get_range(terms)
                if search not in remove:
                    remove[search] = terms
                else:
                    remove[search] += terms
            elif '=' in parameter:
                search,terms = parameter.split('=')
                if capsearch == True:
                    search = search.upper()
                terms = self.get_range(terms)
                if search not in identifiers:
                    identifiers[search] = terms
                else:
                    identifiers[search] += terms
            else:
                if 'generic' not in identifiers:
                    identifiers['generic'] = self.get_range(parameter)
                else:
                    identifiers['generic'] += self.get_range(parameter)
        if 'generic' in identifiers:
            return identifiers['generic']
        else:
            if negative == True:
                return identifiers, remove
            else:
                return identifiers

        
    def generator(self, extract, level):
        output = []
        for text in extract:
            if type(text) == int:
                if level == 'text':
                    output += [text]
                else:
                    for turn in extract[text]:
                        if type(turn) == int:
                            if level == 'turn':
                                output += [(text, turn)]
                            else:
                                for IU in extract[text][turn]:
                                    if type(IU) == int:
                                        if level == 'IU':
                                            output += [(text, turn, IU)]
                                        else:
                                            for word in extract[text][turn][IU]:
                                                if type(word) == int:
                                                    if level == 'word':
                                                        output += [(text, turn, IU, word)]
        output.sort()
        return output
    
    def getParticipants(self, identifier='all', info='all'):
        if identifier != 'all':
            identifiers,remove = self.get_parameters(identifier, negative=True)
            containing = []
            outtakes=[]
            for key in identifiers:
                for participant in metadata:
                    for term in identifiers[key]:
                        pos = participant[self.positions[key]]
                        if type(pos) in [int,float,str]:
                            if term == pos:
                                containing.append(participant)
                        elif type(pos) in [list,tuple]:
                            if term in pos:
                                containing.append(participant)
                        else:
                            outtakes.append(participant)
            output = []
            for participant in containing:
                for key in remove:
                    for term in remove[key]:
                        pos = participant[self.positions[key]]
                        if type(pos) in [int,float,str]:
                            if term == pos:
                                outtakes.append(participant)
                        elif type(pos) in [list,tuple]:
                            if term in pos:
                                outtakes.append(participant)
        else:
            output=[]
            outtakes=[]
            containing = self.copy_object(metadata)
        for participant in containing:
            if participant not in outtakes:
                output += [participant]
        if info == 'all':
            return output
        else:
            output = [x[self.positions[info]] for x in output]
            newoutput = []
            for element in output:
                if type(element) == list:
                    newoutput += [e for e in element if e not in newoutput]
                elif element not in newoutput:
                    newoutput += [element]
            return newoutput

    def printParticipants(self, identifier):
        participants = self.getParticipants(identifier, info='all')
        output = []
        for key in self.positions:
            output.append(key)
        for participant in participants:
            for key in output:
                value = participant[self.positions[key]]
                if type(value) in [int,float]:
                    value = str(value)
                elif type(value) == list:
                    value = ', '.join([str(v) for v in value])
                print (key+': '+value)
            print()
                    
    def format_time(self, flt, decimal=3):
        output = str(flt)
        if decimal > 0:
            if '.' not in output:
              output += '.'
            before = output.split('.')[0]
            after = output.split('.')[1]
            zeros = decimal - len(after)
            if zeros >= 0:
                output += '0'*zeros
                return output
            elif zeros < 0:
                if int(after[zeros]) < 5:
                    return output[:zeros]
                else:
                    after = str(int(after[:zeros])+1)
                if len(after) > decimal:
                    return str(int(before)+1) + '.' + after[1:]
                else:
                    return before + '.' + after
    
    def getTexts(self, subset=None, textlist='all', participants='all'):
        if subset == None:
            subset = self.copy_object(self.corpus)
        output = {}
        if textlist != 'all':
            textlist = self.get_parameters(textlist)
        else:
            textlist = [i for i in range(1,61)]
        if participants == 'all':
            ppl = self.getParticipants(info='ID')
        ppl = self.getParticipants(participants, 'TEXTS')
        for txt in textlist:
            if txt in ppl and txt in subset:
                output[txt] = self.copy_object(subset[txt])
        return output
    
    def getTurns(self, subset=None, textlist='all', turnlist='all', IUlist='all', participants='all', containing='any', afterTurn='any', beforeTurn='any', offset=0, before='any', after='any', at='any', minlength='any', maxlength='any'):
        subset = self.getTexts(subset=subset, textlist=textlist, participants=participants)
        if (containing,IUlist) != ('any','all'):
            IUs = self.getIUs(subset=subset, IUlist=IUlist, containing=containing)
        else:
            IUs=subset
        list(IUs)
        turns = {}
        for text,turn in self.generator(IUs, 'turn'):
            turns = self.copy_part(turns, subset, text, turn)
        output = {}
        if afterTurn != 'any':
            turns_after = {}
            for text,turn in self.generator(afterTurn, 'turn'):
                if text in turns:
                    if turn+1 in turns[text]:
                        turns_after = self.copy_part(turns_after, turns, text, turn+1)
            turns = turns_after
            del turns_after
        if beforeTurn != 'any':
            turns_before = {}
            for text,turn in self.generator(beforeTurn, 'turn'):
                if text in turns:
                    if turn-1 in turns[text]:
                        turns_before = self.copy_part(turns_before, turns, text, turn-1)
            turns = turns_before
            del turns_before
        IDs = [0] + self.getParticipants(participants, 'ID')
        if turnlist != 'all':
            turnlist = self.get_parameters(turnlist)
        for text,turn in self.generator(turns,'turn'):
            accept = True
            if turn+offset in turns[text]:
                if turns[text][turn]['ID'] not in IDs:
                    accept = False
                if turnlist != 'all':
                    if turn + offset not in turnlist:
                        accept = False
                ius = [iu for iu in turns[text][turn+offset] if (type(iu) == int)]
                if ius != []:
                    start = turns[text][turn+offset][min(ius)]['start']
                    end = turns[text][turn+offset][max(ius)]['end']
                    if type(maxlength) in [int, float]:
                        if end - start > maxlength:
                            accept = False
                    if type(minlength) in [int, float]:
                        if end - start < minlength:
                            accept = False
                    if type(at) in [int, float]:
                        if at < start or at > end:
                            accept = False
                    if type(after) in [int, float]:
                        if start < after:
                            accept = False
                    if type(before) in [int, float]:
                        if end > before:
                            accept = False
                elif (maxlength,minlength,at,after,before) != ('any','any','any','any','any'):
                    accept = False
                    print(ius)
            else:
                accept = False
            if accept == True:
                output = self.copy_part(output,turns,text,turn+offset)
        return output      
    
    def getIUs(self, subset=None, textlist='all', turnlist='all', IUlist='all', participants='all', containing='any', after='any', at='any', before='any', maxlength='any', minlength='any'):
        subset = self.getTexts(subset=subset,participants=participants,textlist=textlist)
        if (turnlist,participants) != ('any','all'):
            subset = self.getTurns(subset, turnlist=turnlist, participants=participants)
        IUs = {}
        if containing != 'any':
            words = self.getWords(subset=subset,containing=containing)
            for text,turn,IU in self.generator(words,'IU'):
                IUs = self.copy_part(IUs, subset, text, turn, IU)
            subset = IUs
            del IUs
        output={}
        if IUlist != 'all':
            IUlist = self.get_parameters(IUlist)
        for text,turn,IU in self.generator(subset, 'IU'):
            iu = subset[text][turn][IU]
            accept = True
            if IUlist != 'all':
                if IU not in IUlist:
                    accept = False
            if type(maxlength) in [int, float]:
                if iu['end'] - iu['start'] > maxlength:
                    accept = False
            if type(minlength) in [int, float]:
                if iu['end'] - iu['start'] < minlength:
                    accept = False
            if type(at) in [int, float]:
                if at < iu['start'] or at > iu['end']:
                    accept = False
            if type(after) in [int, float]:
                if iu['start'] < after:
                    accept = False
            if type(before) in [int, float]:
                if iu['end'] > before:
                    accept = False
            if accept == True:
                output = self.copy_part(output, subset, text, turn, IU)
        return output
	
    def getWords(self, subset=None, textlist='all', turnlist='all', IUlist='all', participants='all', containing='all', tier='dt', aslist=False, unit='word', fromstart='any', fromend='any'):
        output = {}
        subset = self.getIUs(subset=subset, textlist=textlist, turnlist=turnlist, IUlist=IUlist, participants=participants)
        if containing != 'all':
            containing,remove = self.get_parameters(containing, negative=True)
        for text,turn,IU,word in self.generator(subset, 'word'):
            accept = True
            if type(fromstart) == int:
                if word > fromstart:
                    accept = False
            if type(fromend) == int:
                for i in range(0,fromend):
                    if word+i not in subset[text][turn][IU]:
                        accept = False
            if containing != 'all':
                for search in containing:
                    for term in containing[search]:
                        if search.lower() in ['dt','word']:
                            if term[0:2] == "r'" and term[-1] == "'":
                                if re.match(term[2:-1],subset[text][turn][IU][word][search.lower()]) == None:
                                    accept = False
                            elif term != subset[text][turn][IU][word][search.lower()]:
                                accept = False
                        elif search.lower() == 'manner':
                            if term not in subset[text][turn][IU][word]['manner'] and term.upper() not in subset[text][turn][IU][word]['manner']:
                                accept = False
                        elif search == 'POS':
                            if term != subset[text][turn][IU][word]['POS']:
                                accept = False
                for search in remove:
                    for term in remove[search]:
                        if search.lower() in ['dt','word']:
                            if term[0:2] == "r'" and term[-1] == "'":
                                if re.match(term[2:-1],subset[text][turn][IU][word][search.lower()]) != None:
                                    accept = False
                            elif term == subset[text][turn][IU][word][search.lower()]:
                                accept = False
                        elif search.lower() == 'manner':
                            if term not in subset[text][turn][IU][word]['manner'] and term.upper() not in subset[text][turn][IU][word]['manner']:
                                accept = False
                        elif search == 'POS':
                            if term != subset[text][turn][IU][word]['POS']:
                                accept = False
            if accept == True:
                output = self.copy_part(output, subset, text, turn, IU, word)
        if aslist == True:
            if unit == 'IU':
                output = self.listWords(output, tier=tier, IUs=True)
            elif unit == 'word':
                output = self.listWords(output, tier=tier, IUs=False)
        return output
        
    def combineSubsets(self, excerpt1, excerpt2=None):
        if type(excerpt1) == list:
            output = self.copy_object(excerpt1[0])
            for subset in excerpt1[1:]:
                for text,turn,IU,word in self.generator(subset, 'word'):
                    output = self.copy_part(output,subset,text,turn,IU,word)
        elif type(excerpt1) == dict and excerpt2 != None:
            output = self.copy_object(excerpt1)
            for text,turn,IU,word in self.generator(excerpt2, 'word'):
                output = self.copy_part(output,excerpt2,text,turn,IU,word)
        return output
	
    def getWindow(self, subset='all', castunit='IU', outputunit='IU', size=10, shift=5):
        output = {}
        complete = [0]
        if subset == 'all':
            subset = self.getTexts()
        if castunit in ['millisecond', 'ms']:
            size = float(size)/1000.000
            shift = float(shift)/1000.000
            minus = 0.001
            castunit = 's'
            if outputunit == 'word':
                print('No data for timing of words. Returning output in IUs.')
                return self.getWindow(subset=subset,castunit=castunit,outputunit='IU',size=size,shift=shift)
        elif castunit in ['second', 's']:
            minus = 1.000
            castunit = 's'
            if outputunit == 'word':
                print('No data for timing of words. Returning output in IUs.')
                return self.getWindow(subset=subset,castunit=castunit,outputunit='IU',size=size,shift=shift)
        elif castunit in ['minute', 'm']:
            size = float(size)*60.000
            shift = float(shift)*60.000
            minus = 60.000
            castunit = 's'
            if outputunit == 'word':
                print('No data for timing of words. Returning output in IUs.')
                return self.getWindow(subset=subset,castunit=castunit,outputunit='IU',size=size,shift=shift)
        elif castunit == 'word':
            if outputunit == 'IU':
                words = self.getWindow(subset=subset, castunit=castunit, outputunit='word', size=size, shift=shift)
                for window in range(0,len(words)):
                    if window+1 not in output:
                        output[window+1] = {}
                    for text,turn,iu in self.generator(words[window], 'IU'):
                        output[window+1] = self.copy_part(output[window+1], subset, text, turn, iu)
            elif outputunit == 'turn':
                words = self.getWindows(subset=subset, castunit=castunit, outputunit='word', size=size, shift=shift)
                for window in range(0,len(words)):
                    if window+1 not in output:
                        output[window+1] = {}
                    for text,turn in self.generator(words[window], 'turn'):
                        output[window+1] = self.copy_part(output[window+1], subset, text, turn)
        elif castunit == 'IU':
            if outputunit == 'turn':
                IUs = self.getWindows(subset=subset, castunit=castunit, outputunit='IU', size=size, shift=shift)
                for window in range(0,len(IUs)):
                    if window+1 not in output:
                        output[window+1] = {}
                    for text,turn in self.generator(IUs[window], 'turn'):
                        output[window+1] = self.copy_part(output[window+1], subset, text, turn)
            if outputunit == 'word':
                return self.getWindow(subset=subset, castunit=castunit, outputunit='IU', size=size, shift=shift)
        elif castunit == 'turn':
            if outputunit in ('IU','word'):
                return self.getWindow(subset=subset, castunit=castunit, outputunit='turn', size=size, shift=shift)
        point = size
        for text in self.generator(subset,'text'):
            if outputunit == 'word':
                if castunit == 'word':
                    complete = [0]
                    wordno=0
                    for txt,trn,iu,wd in self.generator({text:subset[text]},'word'):
                        end = False
                        i = max(complete)+1
                        while end == False:
                            number = size*2
                            if i not in output:
                                output[i] = {}
                            isize = len(self.listWords(words=output[i], IUs=False))
                            point = size + ((i-1) * shift)
                            if number == isize or wordno > size + ((i-1) * shift) + size:
                                complete.append(i)
                            elif point + size >= wordno and point - size <= wordno:
                                output[i] = self.copy_part(output[i], subset, text, trn, iu, wd)
                            else:
                                end = True
                            i+=1
                        wordno += 1
            elif outputunit == 'IU':
                i = 1
                end = False
                if castunit == 'IU':
                    while end == False:
                        minIU = str(point - size)
                        maxIU = str(point + size - 1)
                        IUrange = ':'.join([minIU,maxIU])
                        window = self.getIUs(subset=subset,textlist=text,IUlist=IUrange)
                        if window == {}:
                            end = True
                        else:
                            output[i] = window
                        i+=1
                        point += shift
                elif castunit == 's':
                    while end == False:
                        minIU = point - size
                        maxIU = point + size - minus
                        window = self.combineSubsets([self.getIUs(subset=subset,textlist=text,after=minIU,before=maxIU),
                                                      self.getIUs(subset=subset,textlist=text,at=minIU),
                                                      self.getIUs(subset=subset,textlist=text,at=maxIU)])
                        if window == {}:
                            end = True
                        else:
                            output[i] = window
                        i+=1
                        point += shift
            elif outputunit == 'turn':
                i = 1
                end = False
                if castunit == 's':
                    while end == False:
                        minturn = point - size
                        maxturn = point + size - minus
                        window = self.combineSubsets([self.getTurns(subset=subset,textlist=text,after=minturn,before=maxturn),
                                                      self.getTurns(subset=subset,textlist=text,at=minturn),
                                                      self.getTurns(subset=subset,textlist=text,at=maxturn)])
                        if window == {}:
                            end = True
                        else:
                            output[i] = window
                        i+=1
                        point += shift
        return [output[window] for window in output if output[window] != {}]
        
    def printSubset(self, subset, title=True, tier='dt', timestamps=True, labels=True, numberedlines=False, decimal=3):
        output = ''
        for text in subset:
            output += '\n'
            header = subset[text]['name']+' ('
            turns = [t for t in list(subset[text]) if (type(t) == int)]
            turns.sort()
            turn1 = min(turns)
            IUlist = [iu for iu in list(subset[text][turn1]) if (type(iu) == int)]
            IUlist.sort()
            IU1 = min(IUlist)
            lstturn = max(turns)
            IUlist = [iu for iu in list(subset[text][lstturn]) if (type(iu) == int)]
            lstIU = max(IUlist)
            header += self.format_time(subset[text][turn1][IU1]['start'], decimal) + ' - ' + self.format_time(subset[text][lstturn][lstIU]['end'], decimal) + ')\n'
            if title == True:
                output += header
            for turn in turns:
                IUlist = [i for i in subset[text][turn] if (type(i) == int)]
                IUlist.sort()
                label = subset[text][turn]['ID']
                if label == 0:
                    label = 'OTHER'
                else:
                    label = self.getParticipants('ID='+str(label),'NAME')[-1]
                IU1 = min(IUlist)
                turn_start = self.format_time(subset[text][turn][IU1]['start'], decimal)
                turn_end = self.format_time(subset[text][turn][IU1]['end'], decimal)
                if numberedlines == True:
                    output += str(IU1)+'\t'
                if timestamps == True:
                    output += turn_start + '\t' + turn_end + '\t'
                if labels == True:
                    output += label + ';\t'
                IUtext = []
                words = [wd for wd in list(subset[text][turn][IU1]) if (type(wd) == int)]
                words.sort()
                for word in words:
                    IUtext += [subset[text][turn][IU1][word][tier]]
                output += ' '.join(IUtext) + '\n'
                if len(IUlist) > 1:
                    for IU in IUlist[1:]:
                        IUtext = []
                        turn_start = self.format_time(subset[text][turn][IU]['start'], decimal)
                        turn_end = self.format_time(subset[text][turn][IU]['end'], decimal)
                        if numberedlines == True:
                            output += str(IU)+'\t'
                        if timestamps == True:
                            output += turn_start + '\t' + turn_end + '\t'
                        if labels == True:
                            output += '\t'
                        IUtext = []
                        words = [wd for wd in list(subset[text][turn][IU]) if (type(wd) == int)]
                        words.sort()
                        for word in words:
                            IUtext += [subset[text][turn][IU][word][tier]]
                            for word in IUtext:
                                pass
                        output += ' '.join(IUtext) + '\n'
        print(output)
     
    def listWords(self, words='all', tier='dt', IUs=True):
        wordlist=[]
        IUlist=[]
        if words == 'all':
            words == getTexts()
        prevIU = int
        for text,turn,IU,word in self.generator(words,'word'):
            if IUs == True:
                if prevIU != IU:
                    if prevIU != int:
                        wordlist += [[IUlist]]
                    IUlist = []
                IUlist += [words[text][turn][IU][word][tier]]
                prevIU = IU
            else:
                wordlist += [words[text][turn][IU][word][tier]]
        if IUlist != []:
            wordlist += IUlist
        return wordlist

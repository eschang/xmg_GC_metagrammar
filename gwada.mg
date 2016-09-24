% -------------------------------------------------------
% A Guadeloupean Creole TOY METAGRAMMAR
% -------------------------------------------------------
% 
%init date   = Sept. 2013
%		
% -------------------------------------------------------


use color with () dims (syn)


%% Type declarations

type CAT={
% cat
lex,np,n,v,pred,s,adj,prep,quant,nquant,genitive,advI, Rel,vp,
%flex
poko,péké,
a,lasa,
def,dem,pl,
la,sé,
t,imperf,neg,prosp,ka,ké,té,pa,
jen,predn,preda,adv,nloc,nploc,preploc,beCopFin,wh,negT,rv,ki,q
}

type MARK={subst,foot,none,nadj,anchor,coanchor,flex}

type LABEL !

type BOOL={+,-}
     
type COLOR ={red,black,white}
%% Property declarations

property color      : COLOR
property mark 	    : MARK

%% Feature declarations

feature cat  : CAT
feature proj : CAT
feature nc   : LABEL%BOOL
feature wh   : LABEL


%%%%%%%%%%%%%%%%
%CLASSES   %
%%%%%%%%%%%%%%%%


class CanSubject
export ?X ?Y ?Z
declare ?X ?Y ?Z ?NC
{ <syn>{
        node ?X (color=black)[cat = s, proj = pred]{
                node ?Y (mark=subst,color=black)[cat= np, nc=?NC]
                node ?Z (color=black)[cat = @{pred,v}, proj = @{t,v,prosp,imperf,neg,preploc,nloc,preda,predn}]
                }
        }*=[nc=?NC]
}
%%%%%%%%%%%%%%%%%%%%%%
class RelSubject
export ?X ?Y ?Z ?W ?P
declare ?X ?Y ?Z ?W ?P ?NC
{ <syn>{
	 node ?W (color=black)[cat = n]{
                node ?P (mark=foot,color=red)[cat = n]
                node ?X (color=black)[cat = s]{
		     node ?Y (color=red, mark=subst)[cat = Rel]
		     node ?Z (color=black)[cat = @{pred,v}, proj = @{t,v,prosp,imperf,neg,preploc,nloc,preda,predn}]
						}
                }
	}*=[nc=?NC]
}
%%%%%%%%%%%%%%%%%%%%%%




class Transitive
import Intransitive[]
export ?Z
declare ?Z ?NC
{ <syn>{ node ?Z (mark=subst,color=black)[cat = np, nc=?NC]
         ; ?Y >> ?Z ; ?X -> ?Z
        }*=[nc=?NC]
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class RelObject
export ?X ?Y ?F ?W ?P ?A ?B
declare ?X ?Y ?F ?W ?P ?A ?B
{ <syn>{
	 node ?W (color=red)[cat = n]{
                node ?P (mark=foot,color=red)[cat = n]
                node ?F (color=black)[cat = Rel]{
		     node ?Y (color=red, mark=subst)[cat = Rel]
		     node ?X (color=black)[cat = s, proj = pred]{
		     	    node ?A (mark=subst,color=black)[cat= np]
			     node ?B (color=black)[cat = @{pred,v}, proj = @{t,v,prosp,imperf,neg,preploc,nloc,preda,predn}]
								}
						}
                }
	}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








class Intransitive
export ?X ?Y 
declare ?X ?Y 
{ <syn>{
        node ?X (color=white)[cat = v, proj = v]{
                node ?Y (mark=anchor,color=black)[cat= v, proj = lex]
                }
        }
}

class Ditransitive
import Intransitive[]
export ?Z ?W
declare ?Z ?W
{ <syn>{ node ?Z (mark=subst,color=black)[cat = np];
  	 node ?W (mark=subst,color=black)[cat = np]
         ; ?Y >> ?Z ; ?X -> ?Z ; ?Z >> ?W ; ?X -> ?W
        }
}

class Ditrans_vp
import Intransitive[]
export ?Z ?W
declare ?Z ?W
{ <syn>{ node ?Z (mark=subst,color=black)[cat = np];
  	 node ?W (mark=subst,color=black)[cat = vp]
         ; ?Y >> ?Z ; ?X -> ?Z ; ?Z >> ?W ; ?X -> ?W
        }
}


%%%%%%%%for vp

class v_no_s
export ?X ?Y 
declare ?X ?Y 
{ <syn>{
        node ?X (color=black)[cat = vp, proj = v]{
                node ?Y (mark=anchor,color=black)[cat= v, proj = lex]
                }
        }
}


class vp_trans
import v_no_s[]
export ?Z
declare ?Z ?NC
{ <syn>{ node ?Z (mark=subst,color=black)[cat = np, nc=?NC]
         ; ?Y >> ?Z ; ?X -> ?Z
        }*=[nc=?NC]
}

class vp_ditrans
import v_no_s[]
export ?Z ?W
declare ?Z ?W
{ <syn>{ node ?Z (mark=subst,color=black)[cat = np];
  	 node ?W (mark=subst,color=black)[cat = np]
         ; ?Y >> ?Z ; ?X -> ?Z ; ?Z >> ?W ; ?X -> ?W
        }
}

class vp
{
v_no_s[] | vp_trans[] | vp_ditrans[]
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%TMA




class Imperf
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=white)[cat = pred, proj = imperf]{
                node ?Y (mark=flex,color=red)[cat= ka]
                node ?Z (color=black)[cat = @{pred,v}, proj = @{v,preploc,nloc,preda,predn} ]
                }
        }
}



class Prosp
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=white)[cat = pred, proj = prosp]{
                node ?Y (mark=flex,color=red)[cat= ké]
                node ?Z (color=black)[cat = @{pred,v}, proj = @{imperf,v,preploc,nloc,preda,predn}]
                }
        }
}



class Tensed
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=white)[cat = pred, proj = t]{
                node ?Y (mark=flex,color=red)[cat= té]
                node ?Z (color=black)[cat = @{pred,v}, proj = @{prosp,imperf,v,preploc,nloc,preda,predn}]
                }
        }
}

class Neg
export ?X ?Y ?Z
declare ?X ?Y ?Z ?N 
{ <syn>{
        node ?X (color=white)[cat = pred, proj = neg]{
                node ?Y (mark=flex,color=red)[cat= pa]
                node ?Z (color=black)[cat = @{pred,v}, proj = @{negT,t,prosp,imperf,v,preploc,nloc,preda,predn}]
                }
        }
}
class NegT
export ?X ?Y ?Z
declare ?X ?Y ?Z ?N 

{ <syn>{
        node ?X (color=white)[cat = pred, proj = negT]{
                node ?Y (mark=flex,color=red)[cat= jen]
                node ?Z (color=black)[cat = @{pred,v}, proj = @{t,prosp,imperf,v,preploc,nloc,preda,predn}]
                }
        };
  Neg[]
}







%%%%%%%%%%%%%%%%%%%

class poko
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=white)[cat = pred, proj = neg]{
                node ?Y (mark=flex,color=red)[cat= poko]
                node ?Z (color=black)[cat = @{pred,v}, proj = @{t,prosp,imperf,v,preploc,nloc,preda,predn}]
                }
        }
}

class péké
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=white)[cat = pred, proj = neg]{
                node ?Y (mark=flex,color=red)[cat= péké]
                node ?Z (color=black)[cat = @{pred,v}, proj = @{v,preploc,nloc,preda,predn}]
                }
        }
}







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% transitive and intransitive classes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


class None

class TMA

{
  { Prosp[]  | None[] };
  { Imperf[] | None[] };
  { Tensed[] | None[] };
  {{ Neg[] | NegT[] | poko[] | péké[] }*=[nc= +] | None[]*=[nc= -] }
}

class subject 
{CanSubject[] | RelSubject[] | WhSubject[]}

class n0V
{
  subject[] ;
  Intransitive[];
  TMA[]
}

class VTrans
{
  subject[];
  Transitive[] ;
  TMA[]
}

class n0Vn1n2
{
	subject[] ;
	Ditransitive[];
	TMA[]
}

class n0Vn1vp
{
	subject[] ;
	Ditrans_vp[];
	TMA[]
}



class VTransRelObject
{
RelObject[] ;
TMA[] ;
Intransitive[]
}

%%%%%%%%%

class n0Vn1
{
VTrans[] | VTransRelObject[]
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%COPULA%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class NonVpredn %%% pour les noms prédicatifs 
export ?X ?Y 
declare ?X ?Y 
{ <syn>{
        node ?X (color=white)[cat = pred, proj = predn]{
                node ?Y (mark=anchor,color=black)[cat= predn,proj=lex]
                }
        }
}
class NonVpreda %%%%% pour les adjectifs prédicatifs
export ?X ?Y 
declare ?X ?Y 
{ <syn>{
        node ?X (color=white)[cat = pred, proj = preda]{
                node ?Y (mark=anchor,color=black)[cat= preda,proj=lex]
                }
        }
}

class NonVloc 
export ?X ?Y 
declare ?X ?Y 
{ <syn>{
        node ?X (color=white)[cat = pred, proj = nloc]{
                node ?Y (mark=anchor,color=black)[cat= nloc]
                }
        }
}

class PrepLoc
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=white)[cat = pred, proj = preploc]{
                node ?Z (mark=subst,color=black)[cat = preploc]
                node ?Y (mark=anchor,color=black)[cat = n]
                }
        }
}



class Ploc %%% pour les prépositions locatives
export ?X ?Y
declare ?X ?Y
{ <syn>{
  node ?X (color=red)[cat = preploc]{
        node ?Y (mark=anchor,color=black)[cat = preploc]
	     }
        }
}






class LocPred
{
CanSubject[];
{NonVloc[] | PrepLoc[]} ; 
TMA[]
}


class zeroCop
{
CanSubject[];
{NonVpredn[] | NonVpreda[] } ;
TMA[]
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%      Verb 'être/èt'
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Yé
export ?X ?Y 
declare ?X ?Y 
{ <syn>{
        node ?X (color=white)[cat = v, proj = v]{
                node ?Y (mark=anchor,color=black)[cat= beCopFin, proj = lex]
                }
        }
}



class Vyé
{
{RelObject[] | WhObject[]} ;
{Neg[] | None[]} ;
Yé[]
}





%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% wh

class WhObject
export ?X ?Y ?F ?W ?P ?A ?B ?C ?D
declare ?X ?Y ?F ?W ?P ?A ?B ?C ?D
{ <syn>{
	 node ?W (color=black)[cat = s, proj =q]{ 
                node ?P (mark=subst,color=black)[cat = np] % proj=wh
		     node ?X (color=black)[cat = s, proj = pred]{
		     	  node ?C (mark=flex,color=red)[cat = ki]
		     	   node ?D (color=black)[cat = s, proj = pred]{
		     	    node ?A (mark=subst,color=black)[cat= np]
			     node ?B (color=black)[cat = @{pred,v}, proj = @{v,t,prosp,imperf,neg,preploc,nloc,preda,predn}]
			     	  }
			     }
                }
	}
}

class VTransWhObject
{
WhObject[] ;
TMA[] ;
Intransitive[]
}



class WhSubject
export ?X ?Y ?Z ?W ?P
declare ?X ?Y ?Z ?W ?P ?NC
{ <syn>{
	 node ?W (color=black)[cat = s]{
                node ?P (mark=subst,color=black)[cat = np]
                node ?X (color=black)[cat = s]{
		     node ?Y (mark=flex,color=red)[cat = ki] 
		     node ?Z (color=black)[cat = @{pred,v}, proj = @{t,v,prosp,imperf,neg,preploc,nloc,preda,predn}]
						}
                }
	}
}









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% sé and té %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class sé
{
CanSubject[];
Transitive[]
}









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Adverbs I %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class advI
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = @{pred,v,preploc,nloc,preda,predn}, proj= @{v,imperf,prosp,preploc,nloc,preda,predn}]{
                node ?Y (mark=anchor,color=black)[cat= advI]
                node ?Z (mark=foot,color=black)[cat= @{pred,v,preploc,nloc,preda,predn}, proj= @{v,imperf,prosp,preploc,nloc,preda,predn}]
                 }
        }
}









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Raising Verbs            %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Rverb
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = v, proj= v]{
                node ?Y (mark=anchor,color=black)[cat= rv]
                node ?Z (mark=foot,color=black)[cat= v, proj= v]
                 }
        }
}








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Preposition as modifier             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%prep 'normale'
class Prep
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = prep, proj = prep]{
                node ?Y (mark=anchor,color=black)[cat= prep]
                node ?Z (mark=subst,color=black)[cat = np]
                 }
        }
}





class LFoot
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = v, proj = v]{  
                node ?Y (mark=foot,color=black)[cat = v, proj = v]
		 node ?Z (color=white)[cat= prep, proj = prep]
                }
        }
}


%prep in adjunction

class SP_modif
declare ?LF ?Pr
{
	?LF = LFoot[];
	?Pr = Prep[]
	%; ?SU.?Z =  ?TR.?X

}










%%%%%%%%%%%%%%%%%%%%%%%
%
%  Nouns	
%
%%%%%%%%%%%%%%%%%%%%%%

class Noun
export ?X ?Y
declare ?X ?Y
{ <syn>{
        node ?X (mark=anchor,color=black)[cat = n]
        }
}


class Nounsat
export ?X ?Y 
declare ?X ?Y
{ <syn>{
        node ?X (color=black)[cat = np]{
	     node ?Y (mark=anchor,color=black)[cat = n]
	     }
        }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%
%Projections sur N


class Def
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = n, proj = def]{
                node ?Z (color=white)[cat = n, proj = def]
                node ?Y (mark=flex,color=red)[cat = la]%ajout du co-ancre
                }
        }
}


class Defsat
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = np, proj = def]{
                node ?Z (color=white)[cat = n]
                node ?Y (mark=flex,color=red)[cat = la]%ajout du co-ancre
                }
        }
}

class Dem
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = n, proj = def]{
                node ?Z (color=white)[cat = n, proj = def]
                node ?Y (mark=flex,color=red)[cat = lasa]%ajout du co-ancre
                }
        }
}

class Demsat
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = np, proj = def]{
                node ?Z (color=white)[cat = n, proj = def]
                node ?Y (mark=flex,color=red)[cat = lasa]%ajout du co-ancre
                }
        }
}


class Pl
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = np, proj = pl]{
                node ?Y (mark=flex,color=red)[cat = sé]%ajout du co-ancre
 		node ?Z (color=white)[cat = n, proj = def]
                }
        }
}





class DefN
declare ?DF ?N 
{
	?DF = Defsat[];
	?N = Noun[]
}

class DemN
declare ?DF ?N 
{
	?DF = Demsat[];
	?N = Noun[]
}

class DEF
{
	{Dem[] | Def[]}
}

class PlN
declare ?Pl ?N ?DF
{
	?DF = DEF[];
	?Pl = Pl[];
	?N = Noun[]
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%full class for nouns                          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class NPwthoG    % artefact pour éviter la boucle avec Genitive 
{
	{DemN[] | PlN[] | Nounsat[] | DefN[]}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class NP
{
	{DemN[] | PlN[] | Nounsat[] | DefN[] | Genitive[]}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%% ajout des quantifieurs

class Quant  
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = np, proj = quant]{
                node ?Y (mark=anchor,color=black)[cat = quant]
		 node ?Z (mark=foot,color=black)[cat= np] 
                }
        }
}

%%% negative quantifier 
class NQuant  
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = np, proj = quant, nc= +]{
                node ?Y (mark=anchor,color=black)[cat = nquant]
		 node ?Z (mark=foot,color=black)[cat= np] 
                }
        }
}




%%%%%%%%%%%%%%%%%%%%%%%
%adjective and adjunction%
%%%%%%%%%%%%%%%%%%%%%%%


class Adj
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = n]{
                node ?Y (mark=anchor,color=black)[cat = adj]
                node ?Z (mark=foot,color=black)[cat = n]
                }
        }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Adverb modifier of adjective
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Adv
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = preda]{
                node ?Y (mark=anchor,color=black)[cat = adv]
                node ?Z (mark=foot,color=black)[cat = preda]
                }
        }
}







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%genitival phrase%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class Gen_mark 
export ?X ?Y ?Z ?W ?V
declare ?X ?Y ?Z ?W ?V
{ <syn>{
        node ?X (color=black)[cat = n, proj = n]{
	     node ?W (mark=foot,color=black)[cat = n]
	     node ?V (color=red)[cat = n]{
                node ?Y (mark=flex,color=red)[cat = a]
                node ?Z (color=white)[cat = np]
		     			}
                }
        }
}





class Genitive
declare ?NP  ?GEN
{
	?GEN = Gen_mark[];
	?NP = NPwthoG[]
%	GEN.Z=NP.X
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Interrogatives
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class WhMarkers  
export ?X ?Y ?Z
declare ?X ?Y ?Z
{ <syn>{
        node ?X (color=black)[cat = np, proj = wh]{
                node ?Y (mark=anchor,color=black)[cat = wh]
		 node ?Z (mark=foot,color=black)[cat= np] % cat = n dans la version -1
                }
        }
}










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VALUATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

value n0V

value zeroCop
value n0Vn1n2
value Adj
value Noun 

value Prep
value SP_modif

value NP

value Quant

value Rverb
value advI

%%%%%%value  VTransRelObject
value n0Vn1
value Adv
value LocPred
value Ploc
value Vyé
%%%value sé
%%%%value WhObject
value VTransWhObject
%%%%value WhSubject
%%%%value NonVloc
value WhMarkers
value NQuant
value vp
value  n0Vn1vp 
%%%%%%%%%%%%%%%%%%%%%%%PENDING%%%%%%%%%%%%%%%%%%%%%%%%%















# -*- coding: utf-8 -*-
class Wzorce
	def initialize(wzorzec, tekst)
		@wzorzec = wczytaj_wzorzec(wzorzec)
		@tekst = wczytaj_wzorzec(tekst)
	end
	
	def wczytaj_wzorzec(nazwa_pliku)
		wzorzec = ''
		plikWzorca = File.open(nazwa_pliku,'r')  #dopisać, że w ASCII plik wejścia

		plikWzorca.each_char {|c| 
			if c != "\n"
				wzorzec=wzorzec+c
			end
		}
		plikWzorca.close
		wzorzec
	end

	def brute
		(0..@tekst.length-@wzorzec.length).each { |i|
			j=0
			while j <=@wzorzec.length
				if @wzorzec[j] == @tekst[i+j]
					j=j+1
				else
					break
				end
			end
			if j == @wzorzec.length
				puts "Wzorzec znaleziono na pozycji #{i}"
				i=i+j
			end
		}
	end

	def robin_karp(rozmiar_alfabetu,liczba_pierwsza)
		h=1
		w =  t = 0
		(0..@wzorzec.length-2).each do |i|
			h = (h*rozmiar_alfabetu)%liczba_pierwsza
		end
		#@wzorzec.each_byte {|ascii|
			#w=(w*rozmiar_alfabetu+ascii)%liczba_pierwsza
		#}
		(0..@wzorzec.length-1).each { |ind|
			w=(w*rozmiar_alfabetu+@wzorzec[ind].ord)%liczba_pierwsza
			t=(t*rozmiar_alfabetu+@tekst[ind].ord)%liczba_pierwsza
		}
		
		
		
		(0..@tekst.length-(@wzorzec.length+1)).each { |i|
			if w == t
				j = 0
				while j < @wzorzec.length
					if @wzorzec[j] == @tekst[i+j]
						j=j+1
					else
						break
					end
				end
				if j == @wzorzec.length - 1
					puts "Wzorzec znaleziono na pozycji #{i}"
				end
				if j == @wzorzec.length
					puts "Wzorzec znaleziono na pozycji #{i}"
				end
			end
			t1 = (@tekst[i].ord*h)%liczba_pierwsza
			if t < t1
				t = t+liczba_pierwsza
			end
			t=(rozmiar_alfabetu*(t-t1)+@tekst[i+@wzorzec.length].ord)%liczba_pierwsza	
		}
		
	end

	def compute_prefix
		pi = Array.new(@wzorzec.length)
		pi[0]=0
		k = 0
		(1..@wzorzec.length).each { |q|
			while k > 0 and @wzorzec[q]!=@wzorzec[k]
				k=pi[k]
			end
			if @wzorzec[k]==@wzorzec[q]
				k=k+1
			end
			pi[q]=k
		}
		pi
	end

	def knutt_morris_pratt
		pi = compute_prefix
		q=0
		(0..@tekst.length).each { |i| 
			while q > 0 and @tekst[i]!=@wzorzec[q+1]
				q=pi[q]
			end
			if @tekst[i] == @wzorzec[q+1]
				q=q+1
			end
			if q == @wzorzec.length-1
				puts "Znaleziono wzorzec na pozycji #{i-q}"
				q=pi[q]
			end
		}
	end
	
	def compute_transaction_function(stan,current)
		pi = compute_prefix
		if stan == @wzorzec.length-1 or current!=@wzorzec[stan]
			pi[stan]+1
		else
			stan+1
		end
	end
	def automation_matcher
		stan = 0
		(0..@tekst.length).each { |i|
			stan=compute_transaction_function(stan,@tekst[i])
			if stan == @wzorzec.length-1
				puts "Znaleziono wzorzec na pozycji #{i+1-stan}"
			end	
		}
		
	end
end
wzorce = Wzorce.new("wzorzec.txt","tekst.txt")
puts 'Brute Force:'
wzorce.brute#działa
puts 'Robin Karp:'
wzorce.robin_karp(26,11897) #na razie nie działa
puts 'Knutt Morris Pratt:'
wzorce.knutt_morris_pratt
puts 'Automation Matcher:'
wzorce.automation_matcher#działa
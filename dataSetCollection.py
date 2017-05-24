
import imdb
print "hello world"

dataFile = open('cont.txt', 'w+')
personFile= open('persons2.txt', 'w+')
companyFile = open('companies2.txt', 'w+')

ia = imdb.IMDb()
persons = []
companies = []
info = ""

with open ('u.item', 'r') as movieList:
	for line in movieList:
		movieItems = line.split('|')
		movieId = movieItems[0]
		line = line[2:]  
		movieItems = line.split('|')
		movieName = movieItems[0]
		print movieName
		info  = movieId + ','
		



#LOOP BY MOVIE NAMES
																																																												
																																																											
		s_result = ia.search_movie(movieName)
		print movieId + " " + movieName + " " + str(s_result)
		print "\n\n\n"

		if not s_result:
			info = info + "ERROR\n"
			dataFile.write(info)
		else:
			movie = s_result[0]

			movieId = movie.movieID


			movieInfo = ia.get_movie(movieId)

			#for key, value in movieInfo.iteritems():
			#	print key

			##Actors:
			try:
				cast =  movieInfo['cast']
				for actor in cast[:5]:
					if actor.personID not in persons:
						newPerson = actor.personID + ' ' + str(actor) + '\n'
						personFile.write(newPerson)
						persons.append(actor.personID)
					info = info + str(actor) + '|'
				info = info + ','
				info = info[:-1]
			except KeyError:
				info = info + 'F,'

			#Direcotr
			try:
				director = movieInfo['director'][0]
				if director.personID not in persons:
					newPerson = director.personID + ' ' + str(director) + '\n'
					personFile.write(newPerson)
					persons.append(director.personID)
				info = info + str(director) + ','	
			except KeyError:
				info = info + 'F,'

			#Runtime
			try:
				runtime =  movieInfo['runtime'][0]
				info = info + str(runtime) +','
			except KeyError:
				info = info + 'F,'

			#Producers
			try:
				producers =  movieInfo['producer']
				for producer in producers[:3]:
					if producer.personID not in persons:
						newPerson = producer.personID + ' ' + str(producer) + '\n'
						personFile.write(newPerson)
						persons.append(producer.personID)
					info = info + str(producer) + '|'
				info = info[:-1]
				info = info + ','
			except KeyError:
				info = info + 'F,'

			#Companies
			try:
				pCompany = movieInfo['production companies'][0]

				if pCompany.companyID not in companies:
					newCompany = pCompany.companyID + ' ' + str(pCompany) + '\n'
					companyFile.write(newCompany)
					companies.append(pCompany.companyID)
				info = info + str(pCompany) + ','
			except KeyError:
				info = info + 'F,'

			#Counteries
			try:
				countries =  movieInfo['country codes']
				for countery in countries:
					info = info + str(countery) + '|'
				info = info[:-1] + ','
			except KeyError:
				info = info + 'F,'

			#Languages
			try:
				languages =  movieInfo['languages']
				for language in languages:
					info = info + str(language) + '|'
				info = info[:-1] + ','
			except KeyError:
				info = info + 'F,'

			#Distributor
			try:
				dist =  movieInfo['distributors'][0]
				if dist.companyID not in companies:
					newCompany = dist.companyID + " " + str(dist)
				info = info + str(dist) + '\n'
			except KeyError:
				info = info + 'F,\n'


			dataFile.write(info)
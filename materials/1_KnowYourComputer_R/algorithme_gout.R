# Tout d'abord, lisons le texte. Il sera lu ligne par ligne 
mon_texte <- readLines("Sur la lecture - Marcel Proust.txt")

# Mais il y a un problème. Certaines lignes sont vides
mon_texte[1:5]

# Nous devons donc identifier ces lignes...
lignes_vides <- which(mon_texte == "")

# ...et supprimez-les du texte
mon_texte <- mon_texte[-lignes_vides]

# Ensuite, nous pouvons diviser le texte en mots
# "\\W" est une expression régulière. Elle signifie: tout ce qui n'est pas un caractère (donc les espaces blancs et la ponctuation)
mon_texte <- strsplit(x = mon_texte, split = "\\W")

# le résultat est une "liste", avec toutes les phrases divisées en mots
class(mon_texte)
mon_texte[1:3]

# pour tout avoir sur une seule ligne, il faut le "unlister"
mon_texte <- unlist(mon_texte)

# encore une fois, nous avons généré des espaces blancs
espaces_blancs <- which(mon_texte == "")

# et nous devons les supprimer à nouveau
mon_texte <- mon_texte[-espaces_blancs]

# Le texte est prêt à être analysé!
# Avant de commencer, nous devons définir un compteur pour le mot "goût" et le mettre à zéro
nombre_de_gout <- 0

# Puis on lit tous les mots du texte
for(mot in mon_texte){
  # si le mot est goût
  if(mot == "goût"){
    # nous augmentons le compteur d'un
    nombre_de_gout <- nombre_de_gout+1
  }
}

# ...et voici le résultat!!
nombre_de_gout

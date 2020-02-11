Formation EnExDi 2020

# Introduction: chaîne(s) de traitement(s)

Simon Gabay
Poitiers, mardi 11 février 2020

---

### Chaîne de traitement

On parle de chaîne de traitement (ou "flux de travail" selon la Commission générale de terminologie et de néologie) ou de _Workflow_.
Comme aucune solution informatique ne permet de tout faire (à l'inverse de logiciel comme _Word_ en bureautique), il faut trouver
1. Une série de solutions…
2. … qui s'articulent correctement les unes avec les autres…
3. … et qui correspondent à des standards.

---
### Un exemple de chaîne de traitement pour l'édition numérique

![50% center](TEI_0_images/Workflow.jpg)

Source: Christof Schöch, _Digitale Textedition mit TEI_, [en ligne](https://de.dariah.eu/tei-tutorial).

---
### Philologie numérique

L'édition numérique reprend les étapes de la philologie traditionnelle. Elle ouvre de nouvelles potentialités, malheureusement au prix d'une complexification du travail.

Retour à la renaissance, ou, comme Alde Manuce, l'humaniste maîtrise l'intégralité de la chaîne de production, de la transcription à la publication, en passant par la fabrication des outils (presse, fontes…).

L'édition numérique est avant tout une édition, et nécessite des compétences en ecdotique traditionnelle.

---
### Quelques grandes étapes

1. Transcription -> Kraken, Ocropy, Tesseract…
2. Collation -> Collatex, Juxta…
3. Analyse paléographique -> Archetype…
4. Annotation linguistique -> TreeTagger, Marmot, Pie…
5. Exploitation linguistique -> TXM, Unitex/GramLab…
6. Exploitation littéraire -> Pour les emprunts: Tracer ou Philologic
7. Indexation -> HER, GROBID entity fishing…
8. Publication -> TEIPublisher, Synoptix, LaTeX
9. Archivage -> HAL, Huma-num

---
### Pourquoi dois-je (presque) tout faire?

L'objectif d'avoir un équivalent de _Word_ n'est pas nécessairement souhaitable. Toute simplification se paye:
- Au sens propre avec l'apparition de solutions privées, donc payantes.
- Au sens figuré, avec l'enfermement dans une solution générale qui gère mal les cas particuliers.

Cependant, il existe déjà des chaînes de traitement fonctionnelles et de très grande qualité, comme [METOPES](http://www.numedif.fr/metopes.html) à l'université de Caen.

---
### Quelques grands principes

1. Ouvert
2. Pérenne
3. Interopérable
---
### Un exemple d'enchaînement

![50% center](TEI_0_images/Workflow_2.jpg)

---
### Récupération des données

Le site [Dramacode](http://dramacode.github.io/) publie en ligne les transcriptions en XML-TEI

![50% center](TEI_0_images/Workflow_2_dramacode.png)

---
### La TEI

![80% center](TEI_0_images/Workflow_2_TEI.png)

---
### Traitement avec XSLT

![100% center](TEI_0_images/Workflow_2_XSLT.png)

---
### Texte nettoyé

![100% center](TEI_0_images/Workflow_2_txt.png)

---
### Texte nettoyé

![100% center](TEI_0_images/Workflow_2_txt.png)

---
### Texte annoté

![100% center](TEI_0_images/Workflow_2_gaz.png)

---
### Calcul des scores par pièce

![100% center](TEI_0_images/Workflow_2_scores.png)

---
### Géoréférencement

![100% center](TEI_0_images/Workflow_2_geo.png)

---
### Traitement

![100% center](TEI_0_images/Workflow_2_r.png)

---
### Publication

![100% center](TEI_0_images/Workflow_2_map.png)

---
### Analyse: Racine vs Scarron

![100% center](TEI_0_images/Workflow_2_RacScar.png)


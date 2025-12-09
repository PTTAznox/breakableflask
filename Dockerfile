# Mauvaise pratique : image obsolète et vulnérable
FROM python:3.7

# Mauvaise pratique : on travaille en root (par défaut)
WORKDIR /app

# Mauvaise pratique : utilisation de ADD au lieu de COPY
ADD . /app

# Mauvaise pratique : installation système inutile (gcc, curl…)
RUN apt-get update && apt-get install -y \
    gcc \
    curl \
    wget \
    vim \
    build-essential \
    --no-install-recommends

# Mauvaise pratique : aucun nettoyage des caches
# (Trivy va détecter des vulnérabilités Debian)
RUN pip install -r requirements.txt

# Mauvaise pratique : aucune version fixée dans les requirements
# (Trivy va le signaler si requirements.txt a des dépendances anciennes)

EXPOSE 5000

# Mauvaise pratique : exécuter directement l'app en root
CMD ["python", "main.py"]

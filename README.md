# DBT + Dremio + MinIO + DataHub — Setup rapido

**Overview**
- **Descrizione:** Repository demo per integrare dbt con Dremio, MinIO e DataHub. Contiene configurazioni e modelli per eseguire trasformazioni con dbt e registrare metadati in DataHub.

**Installazione / Requisiti**
- **Prerequisiti:** Docker Compose, Python 3.11, pip.
- **Avvia servizi (Docker Compose):**

```bash
docker compose up -d
```

- **Accessi servizi:**
  - **Dremio:** accedere a http://localhost:9047 e fare login.
  - **MinIO:** accedere a http://localhost:9001 con username/password: `minioadmin` / `minioadmin`.
  - **DataHub:** accedere a http://localhost:9002 (usa username/password configurati per DataHub).

**Configurazioni importanti**
- **Bucket MinIO su Dremio:** assicurarsi di impostare le opzioni S3 corrette in Dremio, ad es.: `fs.s3a.path.style.access` e `fs.s3a.endpoint` verso MinIO.

**Configurazione ambiente Python**
- Crea e attiva virtualenv con Python 3.11:

```bash
python3.11 -m venv venv
source venv/bin/activate
```

- Installa pacchetti necessari:

```bash
pip install --upgrade pip wheel setuptools
pip install dbt-dremio "acryl-datahub[dbt]"
```

**Configurazione DataHub (source Dremio)**
- Esempio di configurazione per la sorgente Dremio in un file di ingestion DataHub:

```yaml
source:
  type: dremio
  config:
    hostname: dremio
    port: 9047
    tls: false
    authentication_method: password
    username: <username>
    password: <password>
    ingest_owner: true
```

**Uso / Comandi**
- Avvia i servizi:

```bash
docker compose up -d
```

- Esegui comandi dbt (esempio):

```bash
source venv/bin/activate
dbt run
dbt test
```

- Esegui l'ingest di DataHub (esempio):

```bash
datahub ingest -c datahub-recipe.yml
```

**Struttura del progetto**
- **File principali:**
  - **dbt_project.yml:** configurazione del progetto dbt
  - **datahub-recipe.yml:** ricetta di ingestion per DataHub
- **Cartelle rilevanti:**
  - `models/` — modelli dbt (staging, source, application, business)
  - `macros/` — macro dbt
  - `seeds/` — dati seed
  - `snapshots/` — snapshot dbt
  - `analyses/` — analisi ad-hoc
  - `target/` — output di compilazione ed esecuzione dbt

**Esempi rapidi**
- Avviare i servizi e preparare l'ambiente:

```bash
docker compose up -d
python3.11 -m venv venv
source venv/bin/activate
pip install --upgrade pip wheel setuptools
pip install dbt-dremio "acryl-datahub[dbt]"
```

- Eseguire dbt e inviare metadati a DataHub:

```bash
dbt compile
dbt docs generate
datahub ingest -c datahub-recipe.yml
```

**Riferimenti**
- https://github.com/dremio/dbt-dremio/blob/main/docs/walkthrough.md
- https://docs.dremio.com/cloud/sonar/client-apps/dbt/
- https://docs.getdbt.com/docs/build/sources
- https://docs.datahub.com/docs/generated/ingestion/sources/dremio

FROM apache/airflow:latest

USER root

ENV AIRFLOW_HOME=/usr/local/airflow
ARG REPO
ENV REPO=$REPO

WORKDIR $AIRFLOW_HOME
COPY dags dags
COPY docker-airflow.cfg airflow.cfg
COPY airflow airflow

RUN pip install --upgrade pip setuptools wheel \
    && pip install -e $AIRFLOW_HOME/airflow[kubernetes] \
    && chown -R airflow $AIRFLOW_HOME

USER airflow

CMD ["bash", "-c"]

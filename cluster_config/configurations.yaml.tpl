---
Configurations:
- Classification: "yarn-site"
  Properties:
    "yarn.log-aggregation-enable": "true"
    "yarn.nodemanager.remote-app-log-dir": "s3://${s3_log_bucket}/${s3_log_prefix}/yarn"
    "yarn.nodemanager.vmem-check-enabled": "false"
    "yarn.nodemanager.pmem-check-enabled": "false"

- Classification: "spark"
  Properties:
    "maximizeResourceAllocation": "false"

- Classification: "spark-defaults"
  Properties:
    "spark.yarn.jars": "/usr/lib/spark/jars/*,/opt/emr/metrics/dependencies/*"
    "spark.sql.catalogImplementation": "hive"
    "spark.yarn.dist.files": "/etc/spark/conf/hive-site.xml,/etc/pki/tls/private/private_key.key,/etc/pki/tls/certs/private_key.crt,/etc/pki/ca-trust/source/anchors/analytical_ca.pem"
    "spark.executor.extraClassPath": "/usr/lib/hadoop-lzo/lib/*:/usr/lib/hadoop/hadoop-aws.jar:/usr/share/aws/aws-java-sdk/*:/usr/share/aws/emr/emrfs/conf:/usr/share/aws/emr/emrfs/lib/*:/usr/share/aws/emr/emrfs/auxlib/*:/usr/share/aws/emr/goodies/lib/emr-spark-goodies.jar:/usr/share/aws/emr/security/conf:/usr/share/aws/emr/security/lib/*:/usr/share/aws/hmclient/lib/aws-glue-datacatalog-spark-client.jar:/usr/share/java/Hive-JSON-Serde/hive-openx-serde.jar:/usr/share/aws/sagemaker-spark-sdk/lib/sagemaker-spark-sdk.jar:/usr/share/aws/emr/s3select/lib/emr-s3-select-spark-connector.jar:/opt/emr/metrics/dependencies/*"
    "spark.driver.extraClassPath": "/usr/lib/hadoop-lzo/lib/*:/usr/lib/hadoop/hadoop-aws.jar:/usr/share/aws/aws-java-sdk/*:/usr/share/aws/emr/emrfs/conf:/usr/share/aws/emr/emrfs/lib/*:/usr/share/aws/emr/emrfs/auxlib/*:/usr/share/aws/emr/goodies/lib/emr-spark-goodies.jar:/usr/share/aws/emr/security/conf:/usr/share/aws/emr/security/lib/*:/usr/share/aws/hmclient/lib/aws-glue-datacatalog-spark-client.jar:/usr/share/java/Hive-JSON-Serde/hive-openx-serde.jar:/usr/share/aws/sagemaker-spark-sdk/lib/sagemaker-spark-sdk.jar:/usr/share/aws/emr/s3select/lib/emr-s3-select-spark-connector.jar:/opt/emr/metrics/dependencies/*"
    "spark.executor.defaultJavaOptions": "-XX:+UseG1GC -XX:+UnlockDiagnosticVMOptions -XX:+G1SummarizeConcMark -XX:InitiatingHeapOccupancyPercent=35 -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:OnOutOfMemoryError='kill -9 %p' -Dhttp.proxyHost='${proxy_http_host}' -Dhttp.proxyPort='${proxy_http_port}' -Dhttp.nonProxyHosts='${proxy_no_proxy}' -Dhttps.proxyHost='${proxy_https_host}' -Dhttps.proxyPort='${proxy_https_port}'"
    "spark.driver.defaultJavaOptions": "-XX:+UseG1GC -XX:+UnlockDiagnosticVMOptions -XX:+G1SummarizeConcMark -XX:InitiatingHeapOccupancyPercent=35 -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:OnOutOfMemoryError='kill -9 %p' -Dhttp.proxyHost='${proxy_http_host}' -Dhttp.proxyPort='${proxy_http_port}' -Dhttp.nonProxyHosts='${proxy_no_proxy}' -Dhttps.proxyHost='${proxy_https_host}' -Dhttps.proxyPort='${proxy_https_port}'"
    "spark.sql.warehouse.dir": "s3://${s3_published_bucket}/data/uc_kickstart/hive/external"
    "spark.executor.cores": "${spark_executor_cores}"
    "spark.executor.instances": "${spark_executor_instances}"
    "spark.executor.memory": "${spark_executor_memory}G"
    "spark.executor.memoryOverhead": "${spark_executor_memoryOverhead}G"
    "spark.driver.memory": "${spark_driver_memory}G"
    "spark.driver.cores": "${spark_driver_cores}"
    "spark.driver.maxResultSize": "0"
    "spark.default.parallelism": "${spark_default_parallelism}"
    "spark.serializer": "org.apache.spark.serializer.KryoSerializer"
    "spark.kryoserializer.buffer.max": "${spark_kyro_buffer}"
    "spark.dynamicAllocation.enabled": "false"

- Classification: "spark-hive-site"
  Properties:
    "hive.txn.manager": "org.apache.hadoop.hive.ql.lockmgr.DbTxnManager"
    "hive.enforce.bucketing": "true"
    "hive.exec.dynamic.partition.mode": "nostrict"
    "hive.compactor.initiator.on": "true"
    "hive.compactor.worker.threads": "1"
    "hive.support.concurrency": "true"
    "javax.jdo.option.ConnectionURL": "jdbc:mysql://${hive_metastore_endpoint}:3306/${hive_metastore_database_name}"
    "javax.jdo.option.ConnectionDriverName": "org.mariadb.jdbc.Driver"
    "javax.jdo.option.ConnectionUserName": "${hive_metsatore_username}"
    "javax.jdo.option.ConnectionPassword": "${hive_metastore_pwd}"
    "hive.metastore.client.socket.timeout": "7200"

- Classification: "hive-site"
  Properties:
    "hive.metastore.warehouse.dir": "s3://${s3_published_bucket}/data/uc_kickstart/hive/external"
    "hive.txn.manager": "org.apache.hadoop.hive.ql.lockmgr.DbTxnManager"
    "hive.enforce.bucketing": "true"
    "hive.exec.dynamic.partition.mode": "nostrict"
    "hive.compactor.initiator.on": "true"
    "hive.compactor.worker.threads": "1"
    "hive.support.concurrency": "true"
    "javax.jdo.option.ConnectionURL": "jdbc:mysql://${hive_metastore_endpoint}:3306/${hive_metastore_database_name}?createDatabaseIfNotExist=true"
    "javax.jdo.option.ConnectionDriverName": "org.mariadb.jdbc.Driver"
    "javax.jdo.option.ConnectionUserName": ${hive_metsatore_username}
    "javax.jdo.option.ConnectionPassword": ${hive_metastore_pwd}
    "hive.metastore.client.socket.timeout": "7200"
    "hive.mapred.mode": "nonstrict"
    "hive.strict.checks.cartesian.product": "false"
    "hive.exec.parallel": "true"
    "hive.exec.failure.hooks": "org.apache.hadoop.hive.ql.hooks.ATSHook"
    "hive.exec.post.hooks": "org.apache.hadoop.hive.ql.hooks.ATSHook"
    "hive.exec.pre.hooks": "org.apache.hadoop.hive.ql.hooks.ATSHook"
    "hive_timeline_logging_enabled": "true"
    %{~ if environment == "production" ~}
    "hive.tez.container.size": "32768"
    "hive.tez.java.opts": "-Xmx26214m"
    "hive.auto.convert.join.noconditionaltask.size": "10922"
    %{~ endif ~}

- Classification: "tez-site"
  Properties:
    "tez.am.resource.memory.mb": "1024"

- Classification: "spark-env"
  Configurations:
  - Classification: "export"
    Properties:
      "PYSPARK_PYTHON": "/usr/bin/python3"

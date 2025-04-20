# server_scripts
server_scripts – a set of scripts for automating server tasks: deployment, monitoring, backups and security. Support for Bash, Python, Linux

server_scripts/  
│  
├── /backup/                  # Скрипты для резервного копирования  
│   ├── mysql_backup.sh       # Бэкап баз данных MySQL  
│   ├── postgres_backup.sh    # Бэкап PostgreSQL  
│   └── files_backup.sh       # Бэкап файлов/директорий  
│  
├── /deploy/                  # Развертывание сервисов  
│   ├── docker_setup.sh       # Установка и настройка Docker  
│   ├── nginx_config.sh       # Автоматическая настройка Nginx  
│   └── certbot_auto.sh       # Обновление SSL-сертификатов  
│  
├── /monitoring/                 # Мониторинг и логи  
│   ├── ip_address_monitoring    # Telegram Bot Setup Guide for IP Monitoring  
│   ├── connection_tracker.sh    # Telegram Bot Configuration Guide for ssh Connection Monitoring
│   └── ip_nginx_status_monitor  # Guide to Setting Up Telegram Bot for Monitoring nginx Sites  
│  
├── /security/               # Безопасность  
│   ├── firewall_rules.sh     # Настройка iptables/firewalld  
│   ├── ssh_hardening.sh      # Усиление безопасности SSH  
│   └── malware_scan.sh       # Проверка на вирусы (ClamAV и др.)  
│  
├── /cloud/                   # Облачные интеграции  
│   ├── aws_ec2_backup.py     # Скрипты для AWS  
│   └── gcp_snapshot.sh       # Управление снапшотами в GCP  
│  
├── /utils/                   # Вспомогательные утилиты  
│   ├── user_management.sh    # Добавление/удаление пользователей  
│   └── cron_job_setup.sh     # Настройка cron-заданий  
│  
├── README.md                 # Основная документация  
├── LICENSE                   # Лицензия (MIT, GPL и т.д.)  
└── .gitignore                # Игнорируемые файлы  

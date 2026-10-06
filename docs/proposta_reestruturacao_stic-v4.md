# PROPOSTA DE REESTRUTURAÇÃO ORGANIZACIONAL DA SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO E COMUNICAÇÃO (STIC) DO TRE-AC

## 1. APRESENTAÇÃO E OBJETIVOS INSTITUCIONAIS

A presente proposta tem por objetivo formalizar a reestruturação organizacional da **Secretaria de Tecnologia da Informação (STI)** do Tribunal Regional Eleitoral do Acre (TRE-AC), promovendo sua transição e elevação para o novo patamar tecnológico sob a nova designação de **Secretaria de Tecnologia da Informação e Comunicação (STIC)** [47].

Esta reformulação atende rigorosamente às diretrizes nacionais estabelecidas pelo Conselho Nacional de Justiça (CNJ), em especial a **Resolução CNJ nº 370/2021** (Estratégia Nacional de Tecnologia da Informação e Comunicação do Poder Judiciário – ENTIC-JUD 2021-2026) [1, 6], à **Resolução CNJ nº 468/2022** (Diretrizes para Contratações de STIC no Poder Judiciário), ao **Plano Estratégico Institucional do TRE-AC (Resolução TRE-AC nº 1.763/2021)** [162] e às diretrizes de atualização do **Regimento Interno da Secretaria (Resolução TRE-AC nº 1.808/2025)** [50, 163].

A reestruturação visa atingir os seguintes objetivos estratégicos:
1. **Adequação Normativa e Designação Atualizada**: Renomear e reestruturar a unidade para **Secretaria de Tecnologia da Informação e Comunicação (STIC)**, refletindo a integração entre infraestrutura tecnológica, governança de dados, cibersegurança e comunicação técnica [47, 48].
2. **Redistribuição Funcional por Afinidade de Processos**: Agrupar atribuições por similaridade de execução, eliminando superposições de competências, reduzindo gargalos operacionais e otimizando a força de trabalho disponível [48].
3. **Integração Orgânica do Planejamento e Execução Eleitoral**: Absorver integralmente as atribuições da antiga *Assessoria de Gestão Eleitoral (AGEL)* – isolada na Diretoria-Geral [167] – e incorporá-las à nova **Coordenadoria de Gestão da Logística e da Eleição (CGLE)**, integrando a gestão de hardwares eleitorais, suprimentos e sistemas ao ciclo tecnológico do pleito [47, 48].
4. **Instituição da Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral**: Criar o órgão colegiado multidisciplinar, presidido pelo(a) Secretário(a) de TIC, encarregado de conduzir de forma contínua o planejamento, a execução e a avaliação dos pleitos oficiais e comunitários na Justiça Eleitoral do Acre.
5. **Otimização das Unidades de Infraestrutura e Soluções Corporativas**: Estruturar a infraestrutura e a engenharia de software em seções com responsabilidades claras sobre Data Centers, nuvem, rede corporativa, segurança cibernética, desenvolvimento ágil e suporte cartorário.
6. **Atendimento Integral aos Macroprocessos Mínimos do CNJ**: Incorporar as estruturas exigidas pelo Art. 21 da ENTIC-JUD (Governança, Planejamento de Contratações, Inteligência de Dados, Segurança da Informação, Inovação, Sustentação em Produção e Simulados Eleitorais) [1, 21, 48].

---

## 2. DIAGNÓSTICO DO CENÁRIO TECNOLÓGICO ATUAL E PRONTIDÃO DO TRE-AC

A reestruturação proposta baseia-se na maturidade do ambiente operacional existente no TRE-AC, que atende ao seguinte diagnóstico técnico:

1. **Infraestrutura Física e Lógica Operacional**: A infraestrutura central de servidores corporativos, redes de computadores, virtualização e links de comunicação encontra-se consolidada, testada e homologada em ambiente de produção [27, 35].
2. **Padronização e Segurança Operacional**: O parque de servidores atua sobre o sistema operacional **Linux Ubuntu 24 (LTS)** em larga escala, com controle de acesso corporativo centralizado no **Microsoft Active Directory (AD)**, proteção de perímetro via *firewalls* avançados e balanceamento por *HAProxy*. O acesso remoto e o teletrabalho utilizam conexões seguras por VPN com **Múltiplo Fator de Autenticação (MFA/Authelia)**.
3. **Atendimento Integral ao Quadro Funcional**: O ambiente computacional provê acesso a 100% dos servidores do quadro permanente, magistrados, colaboradores terceirizados, estagiários e requisitados no Estado, abrangendo a Sede, os Cartórios Eleitorais (1ª a 9ª Zonas) e os Postos de Atendimento ao Eleitor (PAEs) em municípios isolados.
4. **Padronização do Desenvolvimento de Software com IA**: As soluções corporativas internas são desenvolvidas sobre arquitetura padronizada em **PHP, Laravel e banco de dados Oracle**, incorporando suporte a agentes de Inteligência Artificial para otimização de código e automação de rotinas.
5. **Plano de Modernização do Parque de Computadores Fixos e Workstations (DFD nº 0002394-92.2026.6.01.8000)**: Em cumprimento às diretrizes da Presidência do TRE-AC, a STIC formulou a contratação de **127 equipamentos computacionais de alta performance** (120 desktops Dell Pro Slim Core Ultra i5 e 07 Workstations Dell Pro Max Core Ultra i7 com placas NVIDIA RTX A1000 de 8GB), destinados a suportar ambientes críticos como auditoria de urnas, geração de mídias, laboratório de inovação (NULAB), desenvolvimento de sistemas, projetos de engenharia predial (BIM/Revit/AutoCAD) e cartórios eleitorais.
6. **Expectativa de Alta Capacidade Computacional e Mobilidade**: Os postos fixos e móveis demandam poder de processamento para conteinerização (Docker, Kubernetes), ambientes Linux (WSL2), inteligência de dados (Power BI, Oracle, PostgreSQL), monitoramento em tempo real (Zabbix, GLPI) e atuação da Equipe de Tratamento e Resposta a Incidentes Cibernéticos (ETIR).

---

## 3. NOVA ESTRUTURA ORGANIZACIONAL CODIFICADA DA STIC

A arquitetura corporativa da **STIC** é codificada conforme a seguinte árvore hierárquica oficial [47]:

```
1. Secretaria de Tecnologia da Informação e Comunicação (STIC)
   1.01 Gabinete da STIC (GSTIC)
   1.02 Núcleo de Planejamento de TIC (NPTIC)
      1.021 Assistência de Governança de TIC (AGTIC)
      1.022 Assistência de Planejamento e de Contratação (APCTIC)
   1.03 Assessoria de Inteligência de Dados (AIDTIC)
   1.2 Coordenadoria de Infraestrutura (CIE)
      1.21 Seção de Segurança e Inovação Tecnológica (SSIT)
      1.22 Seção de Infraestrutura e Serviços (SINSER)
      1.23 Seção de Suporte aos Usuários (SSU)
   1.3 Coordenadoria de Sistemas Corporativos (CSCOR)
      1.31 Seção de Desenvolvimento de Sistemas (SDSIS)
      1.32 Seção de Sustentação e Manutenção Sistêmica (SSMS)
      1.33 Seção de Sustentação e Banco de Dados (SSBD)
   1.4 Coordenadoria de Gestão da Logística e da Eleição (CGLE)
      1.41 Seção de Logística de Materiais e Urnas Eletrônicas (SLMUE)
      1.42 Seção de Manutenção e Simulados de Urnas (SMSUE)
      1.43 Seção de Sistemas Eleitorais (SSELE)

* Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral (Órgão Colegiado) (CPPGPE)
```

---

## 4. MAPEAMENTO DETALHADO E ATRIBUIÇÕES DAS UNIDADES E SUBUNIDADES

### 1. Secretaria de Tecnologia da Informação e Comunicação (STIC)
- **Função Principal**: Unidade de direção superior responsável por planejar, organizar, dirigir e supervisionar as atividades de TIC, logística eleitoral, infraestrutura, segurança da informação e governança [47, 89, 226]. Precipuamente, o Secretário(a) exerce a Presidência da Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral.
- **Vínculo e Cargo**: Dirigida por Secretário(a), titular de Cargo em Comissão (CJ-3).
- **Atribuições**:
  - Dirigir a execução da ENTIC-JUD no âmbito do TRE-AC, em alinhamento com a Resolução CNJ nº 370/2021, Resolução CNJ nº 468/2022 e diretrizes do TSE [1, 6, 226].
  - Submeter ao Comitê de Governança de TIC e à Administração Superior o Plano Diretor de TIC (PDTIC), o Plano Anual de Contratações de TIC (PAC-TIC) e o Plano de Continuidade de Serviços [11, 228, 229].
  - Supervisionar a integração do planejamento eleitoral, coordenando a recepção do voto informatizado, totalização e transmissão de resultados em tempo real [90, 91, 227].
  - Presidir e conduzir os trabalhos da Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral.

---

### 1.01 Gabinete da STIC (GSTIC)
- **Função Principal**: Suporte administrativo, operacional, documental e de representação institucional da Secretaria [47, 92, 232].
- **Vínculo**: Subordinado ao Secretário(a), sob condução de servidor(a) titular de Função Comissionada (FC-3/FC-4).
- **Atribuições**:
  - Gerir o expediente, a agenda institucional, o fluxo de processos administrativos do SEI e as comunicações internas e externas da Secretaria [92, 232].
  - Elaborar minutas de portarias, ordens de serviço, relatórios de gestão e memórias de reunião [92, 216].
  - Realizar a interlocução de comunicação interna entre as Coordenadorias subordinadas, a Diretoria-Geral e a Presidência [92, 232].

---

### 1.02 Núcleo de Planejamento de TIC (NPTIC)
- **Função Principal**: Gestão tática do alinhamento estratégico, governança, gestão de riscos, métricas (OKRs e iGovTIC-JUD) e planejamento central das contratações de TIC [13, 44, 45, 47, 233].
- **Vínculo**: Vinculado diretamente à Secretaria, sob condução de servidor(a) em Função Comissionada (FC-6).

#### 1.021 Assistência de Governança de TIC (AGTIC)
- **Função Principal**: Execução tática e suporte administrativo para governança, riscos e métricas institucionais.
- **Atribuições**:
  - Implementar e monitorar a aplicação do PDTIC, dos OKRs de TIC e do indicador iGovTIC-JUD do CNJ [44, 45, 235].
  - Mapear e formalizar os processos de trabalho da STIC, mantendo a base de conhecimento e o catálogo de serviços atualizados [229, 230, 237].
  - Coordenar a Gestão de Riscos de TIC e a Continuidade de Negócios da área tecnológica [13, 37, 229, 235].

#### 1.022 Assistência de Planejamento e de Contratação (APCTIC)
- **Função Principal**: Execução tática e instrução operacional das contratações de TIC.
- **Atribuições**:
  - Consolidar e gerir o Plano Anual de Contratações de TIC (PAC-TIC) [16, 229, 235].
  - Apoiar as equipes no planejamento da elaboração de Estudos Técnicos Preliminares (ETP), Termos de Referência (TR) e Análises de Riscos das contratações [231, 253, 254].
  - Monitorar a fase preparatória, o cumprimento de prazos editalícios e a execução orçamentária dos contratos de TIC [16, 235, 253].

---

### 1.03 Assessoria de Inteligência de Dados (AIDTIC)
- **Função Principal**: Gestão de dados institucionais, engenharia de dados, desenvolvimento de painéis em *Business Intelligence* (BI), ciência de dados e apoio à tomada de decisão da Alta Gestão [7, 47, 283].
- **Vínculo**: Vinculada diretamente à Secretaria, sob condução de servidor(a) titular de Cargo em Comissão (CJ-1/CJ-2).
- **Atribuições**:
  - Projetar, construir e manter painéis e dashboards gerenciais em BI para monitoramento de indicadores de desempenho do Tribunal, das Zonas Eleitorais e das eleições [7, 283, 285].
  - Implementar políticas de governança de dados, qualidade de dados e interoperabilidade, atendendo aos requisitos do CNJ (DataJud) e da LGPD [7, 33, 38, 281].
  - Realizar análise preditiva e estatística de dados eleitorais e administrativos para subsidiar decisões estratégicas da Corte [99, 283].

---

### 1.2 Coordenadoria de Infraestrutura (CIE)
- **Função Principal**: Gestão, coordenação e sustentação da infraestrutura física e lógica, serviços de rede, Data Centers, segurança cibernética, engenharia de hardware e atendimento de suporte [27, 47, 68, 238].
- **Vínculo**: Dirigida por Coordenador(a), titular de Cargo em Comissão (CJ-2).
- **Unidades Subordinadas**:

#### 1.21 Seção de Segurança e Inovação Tecnológica
- **Atribuições**:
  - Implementar a Política de Segurança da Informação (PSI), controle de acessos lógicos, gestão de identidades e auditoria de vulnerabilidades [27, 38, 94, 244, 245].
  - Operar os mecanismos de cibersegurança (firewalls, IDS/IPS, antimalware, proteção de nuvem, VPN/Authelia) e gerenciar a Equipe de Tratamento e Resposta a Incidentes Cibernéticos (ETIR) [27, 238, 244].
  - Fomentar e testar soluções tecnológicas inovadoras em parceria com o NULAB e redes de inovação do Poder Judiciário [186, 189, 241].

#### 1.22 Seção de Infraestrutura e Serviços
- **Atribuições**:
  - Administrar os centros de processamento de dados (Data Centers principal e redundante), servidores físicos/virtuais (Ubuntu 24, HAProxy), hipervisores e ambientes em nuvem [27, 35, 239].
  - Gerir os serviços corporativos de rede (DNS, DHCP, Active Directory, e-mail institucional, sistemas de arquivos) e a infraestrutura de backup e disaster recovery [93, 239, 240].
  - Gerenciar o parque de microinformática, nobreaks, ativos de rede, emitindo laudos técnicos, aceites e controle de obsolescência e garantia [28, 96, 97].

#### 1.23 Seção de Suporte aos Usuários
- **Atribuições**:
  - Operar a Central de Serviços (Helpdesk Nível 1 e Nível 2) para atendimento a servidores, magistrados, colaboradores e cartórios eleitorais [28, 98, 243].
  - Garantir o cumprimento dos prazos de atendimento (SLA) e manter atualizada a base de conhecimento de soluções [24, 230, 243].
  - Avaliar a satisfação dos usuários e prover suporte técnico presencial e remoto aos Cartórios Eleitorais do interior e aos PAEs [23, 24].

---

### 1.3 Coordenadoria de Sistemas Corporativos (CSCOR)
- **Função Principal**: Engenharia, desenvolvimento, manutenção, sustentação, administração de bancos de dados e garantia de disponibilidade das soluções tecnológicas do Tribunal [27, 47, 68, 248, 249].
- **Vínculo**: Dirigida por Coordenador(a), titular de Cargo em Comissão (CJ-2).
- **Unidades Subordinadas**:

#### 1.31 Seção de Desenvolvimento de Sistemas
- **Atribuições**:
  - Projetar, construir e codificar novos sistemas e aplicações corporativas em linguagem padronizada (PHP, Laravel, Oracle), adotando suporte de agentes de Inteligência Artificial [27, 102, 249].
  - Garantir a acessibilidade (eMAG), portabilidade, responsividade e segurança desde a concepção (Security by Design) [33].
  - Adotar metodologias ágeis de desenvolvimento, controle de versão (GitLab) e documentação técnica [31, 32, 103, 250].

#### 1.32 Seção de Sustentação e Manutenção Sistêmica
- **Atribuições**:
  - Prestar manutenção evolutiva, corretiva e adaptativa nos sistemas corporativos em uso no Tribunal [47, 102, 249].
  - Avaliar, adaptar, homologar e integrar soluções de software desenvolvidas por outros Tribunais ou pelo TSE antes da implantação local [33, 102, 249].
  - Gerenciar a interoperabilidade e integração de sistemas internos com as plataformas nacionais do CNJ (DataJud, PJe) e TSE [20, 33, 249].

#### 1.33 Seção de Sustentação e Banco de Dados
- **Atribuições**:
  - Administrar, otimizar (tuning) e monitorar os Sistemas Gerenciadores de Bancos de Dados (Oracle, PostgreSQL) do Tribunal [93, 248].
  - Executar rotinas de extração, transformação e carga (ETL), garantindo a integridade dos dados e o suporte à Assessoria de Inteligência de Dados [248].
  - Gerir o ambiente de produção e homologação (CI/CD, Docker, Kubernetes), monitorando em tempo real a disponibilidade, performance e tempo de resposta das aplicações [47, 94, 249, 250].

---

### 1.4 Coordenadoria de Gestão da Logística e da Eleição (CGLE)
- **Função Principal**: Unidade especializada no planejamento operacional, logística, simulados, manutenção de equipamentos eleitorais e condução dos sistemas de votação informatizada [47, 48].
- **Integração Absoluta da AGEL**: Absorve integralmente as atribuições da antiga Assessoria de Gestão Eleitoral (Art. 40 da Res. 1.808/2025), eliminando o isolamento administrativo e unificando o planejamento ao suporte tecnológico direto [48, 213].
- **Vínculo**: Dirigida por Coordenador(a), titular de Cargo em Comissão (CJ-2).
- **Unidades Subordinadas**:

#### 1.41 Seção de Logística de Materiais e Urnas Eletrônicas
- **Atribuições**:
  - Planejar, gerenciar e executar a logística de suprimentos, materiais de votação e contingência de urnas eletrônicas para todas as Zonas Eleitorais [47, 99, 105, 260].
  - Coordenar em parceria com a COSEG/SETRAN a distribuição, transporte, armazenamento seguro e recolhimento das urnas e insumos antes e após o pleito [106, 261, 272].
  - Elaborar tabelas de distribuição, controle de estoque, roteirização logística e dimensionamento físico para eleições oficiais e comunitárias [99, 100, 260].

#### 1.42 Seção de Manutenção e Simulados de Urnas
- **Atribuições**:
  - Realizar as revisões periódicas, testes de mesa, manutenções preventivas e corretivas do parque de urnas eletrônicas (modelos UE) e periféricos [47, 48].
  - Organizar e executar os **Simulados de Eleição, Testes de Carga, Testes de Confirmação, Teste de Autenticidade e Teste de Integridade (Votação Paralela)** [48, 100, 246].
  - Operar as rotinas de geração de mídias de carga e votação, inseminação, lacre e auditoria física e eletrônica das urnas [100, 246].

#### 1.43 Seção de Sistemas Eleitorais
- **Atribuições**:
  - Operacionalizar, homologar e prestar suporte aos sistemas de eleição fornecidos pelo TSE (CAND, Horário Eleitoral, Totalização, Transmissão, Diplomação, Justifica, Oficialização) [47, 48, 246, 281].
  - Capacitar servidores dos Cartórios Eleitorais, juízes eleitorais e membros das Juntas Apuradoras na utilização das soluções e redes de transmissão [246, 281].
  - Executar os planos de transmissão de dados de votação e divulgação dos resultados em tempo real no dia do pleito [91, 242, 246].

---

### COMISSÃO PERMANENTE DE PLANEJAMENTO E GESTÃO DO PLEITO ELEITORAL

- **Natureza**: Órgão colegiado multidisciplinar de caráter permanente, responsável pela coordenação, execução e avaliação continuada das eleições oficiais e não-oficiais (comunitárias) no Estado do Acre.
- **Presidência**: Presidida pelo(a) **Secretário(a) de Tecnologia da Informação e Comunicação**.
- **Composição de Membros**:
  1. **Secretaria de Tecnologia da Informação e Comunicação (STIC)**: 02 (duas) vagas (incluindo o Presidente);
  2. **Coordenadoria de Gestão da Logística e da Eleição (CGLE)**: 01 (uma) vaga;
  3. **Assessoria de Planejamento Institucional (ASPLAN)**: 01 (uma) vaga;
  4. **Secretaria de Administração, Orçamento e Finanças (SAOF)**: 02 (duas) vagas;
  5. **Coordenadoria de Gestão de Pessoas (COGEP)**: 01 (uma) vaga;
  6. **Juízos e Cartórios das Zonas Eleitorais**: 02 (duas) vagas (representando Capital e Interior);
  7. **Corregedoria Regional Eleitoral (CRE)**: 01 (uma) vaga;
  8. **Secretaria Judiciária (SEJUD)**: 02 (duas) vagas.
- **Membro Consultor**:
  - **Juiz Auxiliar indicado pela Presidência do TRE-AC**, com a anuência da Corregedoria Regional Eleitoral (01 vaga).
- **Atribuições Principais**:
  - Mapear e cumprir os regramentos legais e resoluções emitidas pelo TSE para cada pleito.
  - Elaborar o Cronograma Geral de Operações das Eleições, definindo metas, prazos, requisições de transporte, pessoal e contratações de apoio.
  - Providenciar convênios, requisições de veículos, alocação de prédios públicos e locais de votação.
  - Consolidar os relatórios finais do pleito, identificando pontos de melhoria, gargalos e propondo inovações tecnológicas e organizacionais para os pleitos futuros.
  - **Competência do Juiz Consultor**: Produzir os atos normativos, decisões judiciais e interlocuções institucionais necessários à plena execução do pleito que extrapoladores a alçada administrativa da Comissão.

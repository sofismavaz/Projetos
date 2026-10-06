# JUSTIFICATIVA, FUNDAMENTAÇÃO LEGAL, ESTUDO COMPARATIVO E HISTÓRICO DE REESTRUTURAÇÃO DA STIC (TRE-AC)

## 1. FUNDAMENTAÇÃO LEGAL E ALINHAMENTO COM AS DIRETRIZES DO CNJ E TSE

A proposta de reestruturação da **Secretaria de Tecnologia da Informação e Comunicação (STIC)** do Tribunal Regional Eleitoral do Acre (TRE-AC) encontra sólida sustentação no arcabouço normativo do Poder Judiciário Federal [1, 47, 48]:

### 1.1 Resolução CNJ nº 370/2021 (ENTIC-JUD 2021-2026)
- **Art. 21 (Macroprocessos Obrigatórios)**: Exige que a estrutura organizacional de TIC contemple obrigatoriamente quatro macroprocessos fundamentais [26, 27, 28]:
  1. *Governança e Gestão de TIC* (Planejamento, Transformação Digital, Orçamento, Contratações, Riscos, Competências e Comunicação) [26, 27];
  2. *Segurança da Informação e Proteção de Dados* (Incidentes/ETIR, Riscos, Continuidade e Nuvem) [27];
  3. *Desenvolvimento de Soluções e Aplicações* (Requisitos, Arquitetura, Sustentação e Ciclo Seguro) [27];
  4. *Infraestrutura e Serviços* (Data Center, Ativos, Catálogo de Serviços, Central de Atendimento e Satisfação) [27, 28].
- **Art. 6º e Art. 15**: Exige o alinhamento estrito do PDTIC ao Planejamento Estratégico Institucional e ações de Transformação Digital [11, 20].
- **Arts. 45 e 46**: Estabelece o acompanhamento por OKRs e a mensuração contínua pelo índice **iGovTIC-JUD** do CNJ [44, 45].

### 1.2 Resolução CNJ nº 468/2022 (Contratações de STIC no Judiciário)
- Regulamenta as etapas de planejamento (PAC-TIC, ETP, TR e Gestão de Riscos), exigindo uma unidade dedicada ao acompanhamento prévio e controle das contratações tecnológicas, atendida pela **1.022 Assistência de Planejamento e de Contratação**.

### 1.3 Regimento Interno do TRE-AC e Resolução nº 1.808/2025
- Moderniza a regulação regimental (Arts. 48 a 58) e extingue a distorção da antiga Assessoria de Gestão Eleitoral (AGEL - Art. 40), que funcionava isolada da área técnica responsável pela execução real das eleições [167, 168, 213].

---

## 2. EVOLUÇÃO HISTÓRICA DO TRE-AC NAS ÚLTIMAS DÉCADAS

A trajetória organizacional da tecnologia no TRE-AC reflete a evolução do próprio Poder Judiciário Eleitoral [48, 75]:

1. **Década de 2000 (Resolução TRE-AC nº 1.215/2007)**: A informática era tratada como mera atividade de suporte operacional e de manutenção física de computadores, dividida entre suporte e redes [68, 75].
2. **Década de 2010 (Resolução TRE-AC nº 1.646/2011)**: Introduziu a preocupação com estatística e suporte às Zonas Eleitorais, mas manteve a TI sem especialização para governança, inteligência de dados, cibersegurança ou auditoria de urnas [51, 75, 90].
3. **Resolução TRE-AC nº 1.808/2025**: Atualizou nomenclaturas (criando a SCSEG e SSEC), porém perpetuou lacunas graves: ausência de setor de BI/dados, falta de segregação do planejamento contratual e isolamento da AGEL na Diretoria-Geral [168, 169].
4. **Fase Atual (STIC 2026)**: A nova proposta eleva a TIC a nível estratégico, integrando governança, dados, cibersegurança e logística eleitoral sob comando único.

---

## 3. HISTÓRICO DA EVOLUÇÃO TECNOLÓGICA DA JUSTIÇA ELEITORAL E DA URNA ELETRÔNICA

### 3.1 Evolução Tecnológica na Justiça Eleitoral
- **Primeira Fase (Anos 1980/1990)**: Votação em cédulas de papel, apuração manual morosa e suscetível a fraudes humanas e contagem manual em juntas apuradoras.
- **Segunda Fase (Informatização do Cadastro - 1986)**: Criação do cadastro eleitoral único informatizado, preparando o terreno para a automação do voto.
- **Terceira Fase (Redes e Transmissão)**: Implantação de conexões corporativas por satélite (VSAT) e links de dados dedicados para apuração célere e transmissão direta dos municípios do interior.

### 3.2 Evolução da Urna Eletrônica e Mecanismos de Auditoria
- **Surgimento da Urna Eletrônica (1996)**: Projetada por engenheiros brasileiros no TSE, revolucionando a democracia mundial ao eliminar a fraude no momento da votação e contagem.
- **Evolução dos Modelos (UE96 a UE2020/UE2022)**: Introdução do módulo de impressão do voto para auditoria, telas coloridas, leitores biométricos e processadores criptográficos de alta velocidade.
- **Cadeia de Custódia e Auditoria do Processo**:
  1. *Lacração e Assinatura Digital*: Cerimônia pública de assinatura digital e lacração dos softwares desenvolvidos pelo TSE perante partidos, MP e OAB.
  2. *Geração de Mídias e Inseminação*: Carga oficial das urnas realizada em sessões públicas nos TREs com lacres físicos indelevelmente numerados.
  3. *Simulados de Eleição e Testes de Carga*: Realização de simulados estaduais e nacionais para testar a resistência da rede e a integridade do hardware.
  4. *Teste de Confirmabilidade e Autenticidade*: Verificação dos sistemas na véspera e no dia da eleição.
  5. *Teste de Integridade (Votação Paralela)*: Auditoria pública no dia da eleição, onde urnas sorteadas recebem votos de papel auditados paralelamente por empresa de auditoria externa e fiscalizadores em ambiente filmado.

---

## 4. ESTUDO DE BENCHMARKING COM DEMAIS TRIBUNAIS (TSE E TREs)

A pesquisa regimental realizada nos **27 Tribunais Regionais Eleitorais e no TSE** evidencia que [48, 50]:

- **25 Tribunais (92,6%)**: Mantêm a gestão eleitoral, a logística de urnas e o suporte aos sistemas eleitorais **diretamente dentro da Secretaria de Tecnologia da Informação** (estruturadas sob Coordenadorias de Eleições ou Logística Eleitoral).
- **Apenas 2 Tribunais (7,4%)**: Mantinham estrutura de Assessoria isolada na Diretoria-Geral, sendo o TRE-AC um desses casos atípicos.

**Conclusão do Benchmark**: A absorção das competências da AGEL pela **1.4 Coordenadoria de Gestão da Logística e da Eleição (CGLE)** alinha o TRE-AC ao padrão adotado pela esmagadora maioria da Justiça Eleitoral brasileira, garantindo unidade de comando técnico e agilidade operacional [48, 50].

---

## 5. ANÁLISE DE DESEMPENHO DOS SERVIDORES, CRESCENTE DEMANDA E NECESSIDADE DE MÃO DE OBRA ESPECIALIZADA

### 5.1 Fator de Restrição e Desempenho do Quadro Efetivo
- O TRE-AC conta com um **quadro reduzido de servidores efetivos de TIC**, obrigando os profissionais a manterem índices elevados de produtividade e criatividade para suprir a carga de trabalho.
- **Estratégias de Eficiência Adotadas**:
  - Padronização do ambiente de desenvolvimento em **PHP, Laravel e Oracle**.
  - Adoção de **agentes de Inteligência Artificial** para auxílio no desenvolvimento e automação.
  - Virtualização avançada em **Ubuntu 24** com HAProxy, Active Directory e MFA (Authelia).

### 5.2 Expansão Exponencial das Demandas
- A carga de trabalho da STIC cresceu exponencialmente nos últimos anos com a imposição de plataformas nacionais obrigatórias: **PJe, DataJud, SEI, SGRH, eMAG, LGPD, ENTIC-JUD (iGovTIC-JUD), cibersegurança (ETIR), BI e suporte técnico a 9 Zonas Eleitorais e 13 PAEs em municípios isolados**.

### 5.3 Justificativa para Contratação de Mão de Obra Especializada (Outsourcing)
- O limite físico da força de trabalho permanente exige a imediata deflagração do processo de **contratação de serviços técnicos especializados de TI** (suporte técnico corporativo, manutenção do parque computacional de 127 novos desktops/workstations do DFD nº 0002394-92.2026.6.01.8000, suporte cartorário e apoio logístico de urnas).
- Essa mão de obra especializada atuará como camada complementar, liberando os servidores efetivos para as atividades finalísticas de gestão, governança, fiscalização contratual e cibersegurança.

---

## 6. QUADRO COMPARATIVO "DE-PARA" (RES. 1.808/2025 x NOVA PROPOSTA STIC)

| Estrutura Atual (Resolução TRE-AC nº 1.808/2025) [167, 168, 169] | Nova Estrutura Proposta (STIC) [47] | Justificativa da Alteração / Ganho Alcançado [48] |
| :--- | :--- | :--- |
| **Secretaria de Tecnologia da Informação (STI)** [168] | **1. Secretaria de Tecnologia da Informação e Comunicação (STIC)** [47] | Transição para o novo patamar tecnológico e adequação ao padrão nacional [47]. |
| **Assessoria de Gestão Eleitoral (AGEL)** *(vinculada à DG)* [167, 213] | **1.4 Coordenadoria de Gestão da Logística e da Eleição (CGLE)** [47] | Absorção da AGEL e criação de comando único para logística, simulados e sistemas do pleito [48]. |
| *(Não existia)* | **Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral** | Criação de colegiado multidisciplinar permanente presidido pelo Secretário de TIC. |
| **Assistência de Planejamento e Governança (ASPGOVTI)** [168, 233] | **1.02 Núcleo de Planejamento de TIC (NPTIC)**<br>• *1.021 AGTIC*<br>• *1.022 APCTIC* [47] | Segregação e fortalecimento da Governança (OKRs/iGovTIC-JUD) e das Contratações (ETP/TR/Res. 468) [48]. |
| *(Inexistente / atribuição pulverizada)* [48] | **1.03 Assessoria de Inteligência de Dados (AIDTIC)** [47] | Criação de unidade para BI, governança de dados, DataJud, LGPD e ciência de dados [7, 48]. |
| **Seção de Cibersegurança (SCSEG)** [168, 244] | **1.21 Seção de Segurança e Inovação Tecnológica** [47] | Fusão da segurança cibernética (ETIR) com pesquisas de inovação e prototipagem (NULAB) [48, 186]. |
| **Seção de Redes e Suporte (SEREDE / SSU)** [168, 239, 243] | **1.22 Seção de Infraestrutura e Serviços**<br>• **1.23 Seção de Suporte aos Usuários** [47] | Agrupamento de Data Center, nuvem, rede, hardware e backup em uma seção, e suporte cartorário na outra [47, 48]. |
| **Seção de Desenvolvimento e Banco de Dados (SDBD)** [169, 248] | **1.31 Seção de Desenvolvimento de Sistemas**<br>• **1.33 Seção de Sustentação e Banco de Dados** [47] | Especialização da engenharia de software (PHP/Laravel/IA) e sustentação de SGBD (Oracle) com CI/CD [47, 248]. |
| **Seção de Sistemas Eleitorais e Corporativos (SSEC)** [169, 246] | **1.32 Seção de Sustentação e Manutenção Sistêmica** [47] | Foco exclusivo na manutenção evolutiva e interoperabilidade de sistemas corporativos [47, 48]. |
| **Seção de Urnas Eletrônicas (SEUE)** [168] | **1.41 Seção de Logística de Materiais e Urnas**<br>• **1.42 Seção de Manutenção e Simulados**<br>• **1.43 Seção de Sistemas Eleitorais** [47] | Estruturação de 3 seções dedicadas para logística física, simulados/manutenção e operação dos sistemas do TSE [47, 48]. |

---

## 7. DEMONSTRAÇÃO DOS GANHOS DE EFICIÊNCIA E BENEFÍCIOS FUTUROS

1. **Agilidade no Planejamento e Execução do Pleito**: Unificação da gestão eleitoral dentro da STIC e atuação da Comissão Permanente Garantem respostas rápidas aos normativos do TSE [48].
2. **Segurança Cibernética e Resiliência**: Operação da ETIR, firewalls, backup redundante, VPN com MFA e uso de ambiente seguro Linux Ubuntu 24 [27].
3. **Decisão Baseada em Dados e Transparência**: A Assessoria de Inteligência de Dados provê visão em tempo real da biometria, eleitorado e metas institucionais (DataJud/CNJ) [7, 283].
4. **Eficiência Orçamentária e Conformidade**: Instrução criteriosa das compras públicas de TIC (Resolução CNJ nº 468/2022) e acompanhamento rigoroso do PAC-TIC [16, 235].
5. **Capacidade de Atendimento no Interior**: Atendimento qualificado às 9 Zonas Eleitorais e 13 PAEs com estações computacionais de alto desempenho e suporte técnico especializado [28, 98].

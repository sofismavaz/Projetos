CREATE TABLE CadMagistrados (
    matricula INT PRIMARY KEY,
    matriculaAnterior INT,
    cpf CHAR(11) UNIQUE,
    nome VARCHAR(255) NOT NULL,
    dtNascimento DATE,
    idSexo CHAR(1),
    idGenero CHAR(1),
    idRacaCor CHAR(1),
    idDeficiencia CHAR(1),

    email VARCHAR(100),
    identidadeRG VARCHAR(20),
    orgaoExpedidorRG VARCHAR(50),
    ufEmissorRG CHAR(2),
    dtEmissaoRG DATE,
    pisPasep VARCHAR(20),
    certificadoMilitar VARCHAR(20),
    tituloEleitor VARCHAR(20),
    ufTitulo CHAR(2),
    municipioEleitoral VARCHAR(100),
    zonaEleitoral VARCHAR(5),
    secaoEleitoral VARCHAR(5),
    dtExpedicaoTitulo DATE,
    dtUltimaVotacao DATE,

    estadoCivil VARCHAR(50),
    nomeConjuge VARCHAR(255),
    localTrabalhoConjuge VARCHAR(100),
    nomePai VARCHAR(255),
    nomeMae VARCHAR(255),
    qtdeDependentes INT,
    nomeDependentes VARCHAR(255), -- chamar tb aux.

    logradouro VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    ufLogradouro CHAR(2),
    cep CHAR(8),
    foneTrabalho VARCHAR(15),
    foneCelular VARCHAR(15),

    cargo VARCHAR(100),
    regimeCotas VARCHAR(50),
    dtIngresso DATE,
    dtDesligamento DATE,
    orgaoJulgadorLotacao VARCHAR(100),
    situacaoProfissionalAtual VARCHAR(50),
    dtInicioSituacao DATE,
    dtFimSituacao DATE,

    cargoAtual VARCHAR(100),
    regimeCotas BOOLEAN,
    dtIngressoCargoAtual DATE,
    orgaoJulgadorCargoAtual VARCHAR(100),
    situacaoProfissionalCargoAtual VARCHAR(50),
    dtinicioSituacaoCargoAtual DATE,
    drFimSituacaoCargoAtual DATE,

    nivelGraduacao VARCHAR(50),
    areaEspecializacao VARCHAR(100),
    participacaoConselho BOOLEAN,
    instituicaoConselho VARCHAR(100),

    atividadeDocente BOOLEAN,
    instituicaoEnsino VARCHAR(100),
    horarioDisciplina VARCHAR(100),

    banco VARCHAR(100),
    agencia VARCHAR(10),
    contaCorrente VARCHAR(20),
    tipoConta VARCHAR(50),

    idTipoServidor VARCHAR(50),
    onusTribunal VARCHAR(50),
    jornadaTrabalho VARCHAR(50),
    qtdeSalarioFamilia INT,
    salarioOrigem DECIMAL(10, 2),
    vencimentoOrigem DECIMAL(10, 2),
    valorPrevidencia DECIMAL(10, 2),
    patronalOrigem DECIMAL(10, 2),
    ressarcimentoOrigem DECIMAL(10, 2),
    lotacao VARCHAR(100),
    aprovadoTCU BOOLEAN,
    possuiDoenca BOOLEAN,
    dtAposentadoria DATE,
    subtotalPercAposentadoria DECIMAL(5, 2),
    totalPercAposentadoria DECIMAL(5, 2),
    tipoPrevidencia VARCHAR(50),
    licenciado BOOLEAN,
    instituidorPensao BOOLEAN,
    servidorPJ BOOLEAN,
    adicionalInsalubridade DECIMAL(10, 2),
    adicionalPericulosidade DECIMAL(10, 2),
    adicionalAtividadePenosa DECIMAL(10, 2),
    Origem VARCHAR(100),
    nrBienio INT,
    permanencia VARCHAR(50)
);

-- Descrição dos campos:
-- matricula: Número de matrícula (chave primária).
-- matriculaAnterior: Número de matrícula anterior (se houver).
-- nome: Nome completo do magistrado.
-- idSexo: Identificador de sexo (por exemplo, 'M' para masculino, 'F' para feminino).
-- dtNascimento: Data de nascimento.
-- cpf: CPF do magistrado (único).
-- pisPasep: Número do PIS/PASEP.
-- registroGeralRG: Número do RG.
-- orgaoExpedidorRG: Órgão expedidor do RG.
-- uf: Unidade Federativa (sigla de 2 caracteres).
-- fonePessoal: Telefone pessoal.
-- foneTrabalho: Telefone de trabalho.
-- logradouro: Endereço (logradouro).
-- bairro: Bairro.
-- cidade: Cidade.
-- cep: Código endereçamento postal (CEP).
-- dtIngresso: Data de ingresso.
-- dtDesligamento: Data de desligamento.
-- idSituacao: Situação atual do magistrado - Tab aux.
-- idTipoServidor: Tipo de servidor - Tab aux.
-- onusTribunal: Ônus do tribunal (Sim ou Não).
-- jornadaTrabalho: Jornada de trabalho.
-- qtdeSalarioFamilia: Quantidade de salário-família.
-- salarioOrigem: Salário de origem.
-- vencimentoOrigem: Vencimento de origem.
-- valorPrevidencia: Valor da previdência.
-- patronalOrigem: Patronal de origem.
-- ressarcimentoOrigem: Ressarcimento de origem.
-- idLotacao: Lotação do magistrado Tab Aux.
-- aprovadoTCU: Indica se foi aprovado pelo TCU (booleano).
-- possuiDoenca: Indica se possui doença (booleano).
-- dtAposentadoria: Data de aposentadoria.
-- subtotalPercAposentadoria: Subtotal percentual de aposentadoria.
-- totalPercAposentadoria: Total percentual de aposentadoria.
-- tipoPrevidencia: Tipo de previdência.
-- licenciado: Indica se está licenciado (booleano).
-- instituidorPensao: Indica se é instituidor de pensão (booleano).
-- servidorPJ: Indica se é servidor PJ (booleano).
-- adicionalInsalubridade: Valor do adicional de insalubridade.
-- adicionalPericulosidade: Valor do adicional de periculosidade.
-- adicionalAtividadePenosa: Valor do adicional de atividade penosa.
-- Origem: Origem do magistrado.
-- nrBienio: Número do biênio.
-- permanencia: Informação sobre permanência.

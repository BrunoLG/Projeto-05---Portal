create table tb_permissao (
    cd_permissao BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_permissao varchar(20)
);

insert into tb_permissao values 
    (default,'admin'),
    (default,'professor'),
    (default,'aluno');

create table tb_curso (
    cd_curso BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_curso varchar(60)
);

insert into tb_curso values 
    (default, 'Nenhum'),
    (default, 'Análise e Desenvolvimento de Sistemas'),
    (default, 'Comércio Exterior'),
    (default, 'Processos Químicos');

create table tb_usuario (
    cd_usuario BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_usuario varchar(100),
    nm_login varchar(30),
    cd_senha BIGINT,
    cd_curso BIGINT,
    cd_permissao BIGINT,

    constraint fk_usuario_curso foreign key (cd_curso) references tb_curso (cd_curso),
    constraint fk_usuario_permissao foreign key (cd_permissao) references tb_permissao (cd_permissao)
);

insert into tb_usuario values 
    (default, 'Administrador Supremo', 'admin', 1509442, 1, 1),
    (default, 'Fernando Bacic', 'professor', 1509442, 2, 2),
    (default, 'Ricardo Pupo', 'pupo', 1509442, 3, 2),
    (default, 'Paolla Gil', 'paolla', 1509442, 2, 3),
    (default, 'Milena Alves', 'milena', 1509442, 3, 3),
    (default, 'Leonardo Santos', 'leonardo', 1509442, 4, 3);

create table tb_disciplina (
    cd_disciplina BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_disciplina varchar(100),
    cd_curso BIGINT,
    
    constraint fk_disciplina_curso foreign key (cd_curso) references tb_curso (cd_curso)
);

insert into tb_disciplina values 
    (default, 'Matemática Discreta', 2),
    (default, 'Arquitetura de Computadores', 2),
    (default, 'Economia e Finanças', 3),
    (default, 'Química', 4),
    (default, 'Física', 4),
    (default, 'Marketing internacional', 3);

create table tb_aula (
    cd_aula BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_aula varchar(100),
    ds_conteudo varchar(10000),
    cd_disciplina BIGINT,

    constraint fk_aula_disciplina foreign key (cd_disciplina) references tb_disciplina (cd_disciplina)
);

insert into tb_aula values 
    (default, 'Teoria dos Grafos', 'A teoria dos grafos tem a sua origem na necessidade de representar por esquemas as relações existentes entre os elementos de um conjunto. Neste sentido, constitui um ramo específico da teoria das relações binárias definidas num conjunto. Esta teoria cobre um vasto campo de aplicações que v˜ao desde a física até certos domínios da arte, passando pela química, biologia, sociologia, economia, gest˜ao, engenharia, etc. A noção de digrafo ou grafo dirigido, foi já referida a propósito da representação geométrica de uma relação binária definida num conjunto. Se R for uma rela¸c˜ao simétrica, ent˜ao sempre que (xi, xj ) pertence ao digrafo também (xj , xi) lhe pertencerá. Neste caso a ligação entre dois vértices (quando existe) faz-se sempre nos dois sentidos, podendo representar-se este facto por uma aresta única (n˜ao dirigida). Obtém-se, assim, um grafo n˜ao dirigido (ou, simplesmente, grafo). Embora a teoria dos grafos seja um instrumento natural para o estudo das relações binárias, há, hoje em dia, muitos outros tópicos de matemática quer pura quer aplicada para os quais o recurso à teoria dos grafos constitui uma atitude natural.', 1),
    (default, 'Álgebras de Boole', 'Se se observarem bem as propriedades das operações com conjuntos e as propriedades das operações lógicas do cálculo proposicional, chegar-se à conclus˜ao de que, sob um ponto de vista formal, elas s˜ao muito semelhantes. (Recordar, por exemplo, a distributividade das operações ∪,∩ e a distributividade das operações ∨,∧ ou as leis de Morgan relativas ás operações ∪,∩ e as leis de Morgan relativas ás operações ∨,∧.) Este facto mostra que a algebra dos conjuntos e o cálculo proposicional têm uma estrutura algébrica idêntica, constituindo dois exemplos típicos do que se designa por álgebras de Boole ou álgebras booleanas. Começar-se á por definir o que se entende por álgebra de Boole abstracta, podendo depois verificar-se como esta estrutura é comum tanto à teoria dos conjuntos como á lógica proposicional.', 1),
    (default, 'Números Naturais', 'A aritmética dos números naturais baseia-se em duas operações: a adição e a multiplicação. Nenhuma destas operações recebe uma menção explícita na Axiomática de Dedekind-Peano o que significa que as mesmas podem ser definidas em termos das noções já introduzidas. Tal modo de proceder apresenta, no entanto, um acréscimo de dificuldades pelo que se adoptará aqui o ponto de vista que consiste em introduzir as definições de adição e multiplicação em IN de forma axiomática podendo depois deduzir-se toda a aritmética dos números naturais fazendo repetido apelo ao princípio da indução matemática.', 1),
    (default, 'Processador', 'Um microprocessador, ou simplesmente processador, é um circuito integrado (ou chip), que é considerado o "cérebro" do computador. É ele que executa os programas, faz os cálculos e toma as decisões, de acordo com as instruções armazenadas na memória.  Os microprocessadores formam uma parte importantíssima do computador, chamada de UCP (Unidade Central de Processamento), ou em inglês, CPU (Central Processing Unit). Antes da existência dos microprocessadores, as CPUs dos computadores eram formadas por um grande número de chips, distribuídos ao longo de uma ou diversas placas. Um microprocessador nada mais é que uma CPU inteira, dentro de um único CHIP. Podemos ver na Figura 3 um microprocessador e uma placa de circuito. Um microprocessador contém todos os circuitos que antigamente eram formados por diversas placas.', 2),
    (default, 'Memória', 'Todo computador é dotado de uma quantidade de memória (que pode variar de máquina para máquina) a qual se constitui de um conjunto de circuitos capazes de armazenar os dados e os programas a serem executados pela máquina. Nós podemos identificar diferentes categorias de memória: a memória principal, ou memória de trabalho, onde normalmente devem estar armazenados os programas e dados a serem manipulados pelo processador; a memória secundária que permitem armazenar uma maior quantidade de dados e instruções por um período de tempo mais longo; o disco rígido é o exemplo mais evidente de memória secundária de um computador, mas podem ser citados outros dispositivos menos recentes como as unidades de fita magnética e os cartões perfurados; e a a memória cache, que se constitui de uma pequena porção de memória com curto tempo de resposta, normalmente integrada aos processadores e que permite incrementar o desempenho durante a execução de um programa.', 2),
    (default, 'Barramentos', 'Um barramento, ou bus, nada mais é do que um caminho comum pelo qual os dados trafegam dentro do computador. Este caminho é usado para comunicações e pode ser estabelecido entre dois ou mais elementos do computador. O tamanho de um barramento é importante pois ele determina quantos dados podem ser transmitidos em uma única vez. Por exemplo, um barramento de 16 bits pode transmitir 16 bits de dado, e um barramento de 32 bits pode transmitir 32 bits de dados a cada vez. Todo barramento tem uma velocidade medida em MHz. Um barramento rápido permite transmitir dados rapidamente, que tornam as aplicações mais rápidas.', 2),
    (default, 'PIB', 'O produto interno bruto (PIB) representa a soma (em valores monetários) de todos os bens e serviços finais produzidos numa determinada região (quer sejam países, estados ou cidades), durante um período determinado (mês, trimestre, ano etc). O PIB é um dos indicadores mais utilizados na macroeconomia com o objetivo de quantificar a atividade econômica de uma região. Na contagem do PIB, considera-se apenas bens e serviços finais, excluindo da conta todos os bens de consumo de intermediário. Isso é feito com o intuito de evitar o problema da dupla contagem, quando valores gerados na cadeia de produção aparecem contados duas vezes na soma do PIB.', 3),
    (default, 'Juros', 'Taxas de juros são o preço de se viver em um mundo que depende fortemente de crédito e débito. Se as taxas de juros não existissem, os credores não teriam motivos para te emprestar dinheiro. E se você não pode pedir dinheiro emprestado, você não pode pagar por coisas que você não conseguiria pagar no momento, como uma casa ou um carro, ou desfrutar de muitas outras coisas, como pagar por serviços de streaming, ou fazer compras on-line com o cartão de crédito. Para quem está guardando dinheiro, por outro lado, as taxas de juros são efetivamente a taxa que o banco ou outra instituição financeira irá te pagar por emprestar o seu dinheiro. O dinheiro que você ganha nessas economias são chamados de juros.', 3),
    (default, 'Amortização', 'Amortização é um processo de extinção de uma dívida através de pagamentos periódicos, que são realizados em função de um planejamento, de modo que cada prestação corresponde à soma do reembolso do capital ou do pagamento dos juros do saldo devedor, podendo ser o reembolso de ambos, sendo que os juros são sempre calculados sobre o saldo devedor. No Brasil, existe amortização contábil, cujo conceito não se restringe à diminuição de dívidas, mas também a direitos intangíveis classificados no ativo (conta de balanço), derivado da teoria de dimensão econômico dos fundos contábeis. Assim, associa-se o termo amortização contábil, à depreciação contábil (redução de bens tangíveis) e à exaustão contábil (recursos naturais).', 3),
    (default, 'Ebulição', 'Em muitas receitas é usado o termo “levantar fervura” para indicar o momento em que as primeiras bolhas começam a surgir num líquido sob aquecimento. Mas por que essas bolhas surgem? Quando aquecemos alguma substância que se encontra em seu estado líquido, estamos fornecendo energia em forma de calor a suas partículas que, quando absorverem energia o suficiente para vencer a interação de umas com as outras (forças de atração) passarão a um novo estado físico, chamado gasoso, no qual encontrar-se-ão mais dispersas e com maior energia cinética. A este processo, dá-se o nome de ebulição.', 4),
    (default, 'Fusão', 'A matéria está sempre sujeita a transformações, que podem ser químicas ou físicas. As transformações químicas alteram a natureza dos compostos reagentes, gerando novas substâncias como produtos, como por exemplo, a queima (ou combustão) de papel. Já as transformações físicas são aquelas que não alteram a natureza do composto e não geram novas substâncias, como por exemplo, o ato de amassar um papel, ou o derretimento das calotas polares. Neste último caso, o que ocorre é uma transformação física chamada mudança de estado físico. Toda matéria encontra-se em algum estado físico e, dependendo das condições de pressão e temperatura, pode passar para outros estados. Esse tipo de transformação está ocorrendo a todo tempo ao nosso redor, como, por exemplo, no gelo do nosso copo de suco, que está passando do estado sólido ao líquido, diluindo o suco e tornando-o mais “aguado”, ou ainda, no vapor que está presente no ar, que, ao entrar em contato com a superfície gelada do copo, vira líquido, formando gotas de água ao redor do copo gelado, dando a impressão do copo “suando”. A passagem do estado sólido ao estado líquido é chamada de fusão, ou, como popularmente é conhecida, derretimento. O gelo, tanto das calotas polares, quanto do nosso copo de suco, se tornando água líquida é um exemplo de fusão. Outros exemplos que podem ser citados é o derretimento de uma vela acesa (fusão da parafina), o início do processo de fundição, em que se aquece um metal sólido até que se torne líquido, afim de torná-lo moldável, dentre outros.', 4),
    (default, 'Balanceamento de Equações Químicas', 'A estequiometria de uma reação química é de suma importância por informar o reagente limitante, a massa e volume (no caso de gases) finais dos produtos, a quantidade de reagentes que deve ser adicionada para que determinada quantidade de produto seja obtido, dentre outros dados. Portanto, o balanceamento de equações químicas deve ser feita sempre que se deseja retirar alguma informação acerca de uma reação fornecida.', 4),
    (default, 'Eletrostática', 'A eletrostática é a parte da Física responsável pelo estudo das cargas elétricas em repouso. Ao longo da história, grandes pesquisadores como Tales de Mileto conseguiram verificar a existência das cargas elétricas. Segundo Maurício Ruv Lemes, foi Tales quem primeiro conseguiu verificar, em 600 a. C., que o âmbar, após atritado, consegue atrair fragmentos de palha. Em 1600, o médico inglês William Gilbert (1540-1603) publicou o livro Sobre os Ímãs, sobre os Corpos Magnéticos, e sobre o Grande Ímã, a Terra. Neste livro, Gilbert faz uma analogia comparando a Terra com um enorme ímã, onde os pólos magnéticos do Globo estariam localizados junto aos pólos geográficos. Gilbert também estudou os fenômenos elétricos, chegando a concluir que existiam mais substâncias além do âmbar que possuíam propriedades eletrostáticas, de acordo com CHAIB e ASSIS (2007).', 5),
    (default, 'Difração', 'Denomina-se difração o desvio sofrido por ondas ao passarem por um obstáculo, tal como as bordas de uma fenda em um anteparo. Pode-se ver a difração da luz, por exemplo, olhando-se para uma fonte luminosa distante, tal como um anúncio de néon através da fenda formada entre dois dedos, ou observando a luz que escoa pelo tecido de um guarda-chuva. Em geral os efeitos de difração são muito pequenos, devendo ser analisados e investigados minuciosamente. ', 5),
    (default, 'Campo Magnético', 'Em elétrica cada carga cria em torno de si um campo elétrico, de modo análogo o imã cria um campo magnético, porém num imã não existe um mono-pólo assim sempre o imã tem a carga positiva e a negativa. Para representarmos o campo magnético usaremos o símbolo B . Para determinar o sentido de B utilizamos uma bússola ( que só a partir dos estudos do magnetismo pôde ser utilizada para a navegação, com grande importância até nos dias de hoje).', 5),
    (default, 'Marketing Global', 'Neste contexto de empresas buscando participação em todos os mercados , o marketing global identificou o mundo com uma perspectiva de mercado único. Para a exploração dessa nova realidade de mercado global, foi necessário combinar a ciência e a arte do Marketing, com outras disciplinas como: geografia, história, línguas, economia, antropologia, estudo das diferentes culturas, jurisprudência, estatística, e outras. ', 6),
    (default, 'Atratividade do Mercado e Concorrentes', 'Além dos fatores econômicos e de tamanho de mercado, uma série de fatores estratégicos de atratividade do mercado deve ser analizada. Para avaliação da atratividade de um mercado, devemos consideram um importante aspecto: a rentabilidade da empresa dentro desse mercado. Para isso, depois de escolhido o mercado alvo segmentado, o melhor posicionamento a ser determinado e a estratégia estipulada, de acordo com esse posicionamento, poderemos avaliar a sua rentabilidade. ', 6),
    (default, 'Aspectos Culturais', 'O grande desafio para uma empresa em um novo mercado é a maneira de lidar com as diferenças nos padrões de comportamento, valores e atitudes que dirigem o comportamento humano. A dificuldade está nas diferenças no comportamento do consumidor e na maneira como este interage com a implementação dos programas de Marketing. Pois, como se diz popularmente, uma cultura não se aprende, se vivencia ! As diferenças culturais podem ser enormes, e se não forem tratadas com cuidado podem trazer grandes problemas. Por exemplo, entre note-americanos e japoneses, que são classificados de acordo com Geert HOFSTEDE (1993), como participantes de culturas de baixo e alto contexto, respectivamente teremos com certeza problemas de comunicação, pois os primeiros estão acostumados com a informação explícita nas palavras, e os outros necessitam do contexto para entender a informação.', 6);

create table tb_teste (
    cd_teste BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_teste varchar(100),
    cd_disciplina BIGINT,
    
    constraint fk_teste_disciplina foreign key (cd_disciplina) references tb_disciplina (cd_disciplina)
);

insert into tb_teste values 
    (default, 'Teste Final - Matemática Discreta', 1),
    (default, 'Teste Final - Arquitetura de Computadores', 2),
    (default, 'Teste Final - Economia e Finanças', 3),
    (default, 'Teste Final - Química', 4),
    (default, 'Teste Final - Física', 5),
    (default, 'Teste Final - Marketing internacional', 6);


create table tb_questao (
    cd_questao BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    ds_questao varchar(10000),
    nm_resposta varchar(300),
    cd_teste BIGINT,

    constraint fk_questao_teste foreign key (cd_teste) references tb_teste (cd_teste)
);

insert into tb_questao values 
    (default, 'Diante dessas inconsistências e de outras que ainda preocupam a opinião pública, nós, jornalistas, estamos encaminhando este documento ao Sindicato dos Jornalistas Profissionais no Estado de São Paulo, para que o entregue à Justiça; e da Justiça esperamos a realização de novas diligências capazes de levar à completa elucidação desses fatos e de outros que porventura vierem a ser levantados. A morte do jornalista Vladimir Herzog, ocorrida durante o regime militar, em 1975, levou a medidas como o abaixoassinado feito por profissionais da imprensa de São Paulo. A análise dessa medida tomada indica a', 'expectativa da investigação dos culpados.', 1),
    (default, 'As Brigadas Internacionais foram unidades de combatentes formadas por voluntários de 53 nacionalidades dispostos a lutar em defesa da República espanhola. Estima-se que cerca de 60 mil cidadãos de várias partes do mundo – incluindo 40 brasileiros – tenham se incorporado a essas unidades. Apesar de coordenadas pelos comunistas, as Brigadas contaram com membros socialistas, liberais e de outras correntes político-ideológicas. A Guerra Civil Espanhola expressou as disputas em curso na Europa na década de 1930. A perspectiva política comum que promoveu a mobilização descrita foi o(a)', 'combate ao fascismo.', 1),
    (default, 'A singularidade da questão da terra na África Colonial é a expropriação por parte do colonizador e as desigualdades raciais no acesso à terra. Após a independência, as populações de colonos brancos tenderam a diminuir, apesar de a proporção de terra em posse da minoria branca não ter diminuído proporcionalmente. Com base no texto, uma característica socioespacial e um consequente desdobramento que marcou o processo de ocupação do espaço rural na África subsaariana foram:', 'Concentração das áreas cultiváveis no setor agroexportador – Aumento da ocupação da população pobre em territórios agrícolas marginais.', 1),
    (default, 'Mas uma coisa ouso afirmar, porque há muitos testemunhos, e é que vi nesta terra de Veragua ( Panamá ) maiores indícios de ouro nos dois primeiros dias do que na Hispaniola em quatro anos, e que as terras da região não podem ser mais bonitas nem mais bem lavradas. Ali, se quiserem podem mandar extrair à vontade. O documento permite identificar um interesse econômico espanhol na colonização da América a partir do século XV. A implicação desse interesse na ocupação do espaço americano está indicada na', 'fundação de cidades para controlar a circulação de riquezas.', 2),
    (default, 'Em 1961, o presidente De Gaulle apelou com êxito aos recrutas franceses contra o golpe militar dos seus comandados, porque os soldados podiam ouvi-lo em rádios portáteis. Na década de 1970, os discursos do aiatolá Khomeini, líder exilado da futura Revolução Iraniana, eram gravados em fita magnética e prontamente levados para o Irã, copiados e difundidos. Os exemplos mencionados no texto evidenciam um uso dos meios de comunicação identificado na', 'promoção da mobilização política.', 2),
    (default, 'A recuperação da herança cultural africana deve levar em conta o que é próprio do processo cultural: seu movimento, pluralidade e complexidade. Não se trata, portanto, do resgate ingênuo do passado nem do seu cultivo nostálgico, mas de procurar perceber o próprio rosto cultural brasileiro. O que se quer é captar seu movimento para melhor compreendê-lo historicamente. Com base no texto, a análise de manifestações culturais de origem africana, como a capoeira ou o candomblé, deve considerar que elas', 'derivam da interação entre valores africanos e a experiência histórica brasileira.', 2),
    (default, 'TEXTO I - O presidente do jornal de maior circulação do país destacava também os avanços econômicos obtidos naqueles vinte anos, mas, ao justificar sua adesão aos militares em 1964, deixava clara sua crença de que a intervenção fora imprescindível para a manutenção da democracia. TEXTO II - Nada pode ser colocado em compensação à perda das liberdades individuais. Não existe nada de bom quando se aceita uma solução autoritária. Embora enfatizem a defesa da democracia, as visões do movimento político-militar de 1964 divergem ao focarem, respectivamente:', 'Razões de Estado — Soberania popular.', 3),
    (default, 'Uma mesma empresa pode ter sua sede administrativa onde os impostos são menores, as unidades de produção onde os salários são os mais baixos, os capitais onde os juros são os mais altos e seus executivos vivendo onde a qualidade de vida é mais elevada. No texto estão apresentadas estratégias empresariais no contexto da globalização. Uma consequência social derivada dessas estratégias tem sido', 'o aumento da mobilidade ocupacional.', 3),
    (default, 'Texto I - O que vemos no país é uma espécie de espraiamento e a manifestação da agressividade através da violência. Isso se desdobra de maneira evidente na criminalidade, que está presente em todos os redutos — seja nas áreas abandonadas pelo poder público, seja na política ou no futebol. O brasileiro não é mais violento do que outros povos, mas a fragilidade do exercício e do reconhecimento da cidadania e a ausência do Estado em vários territórios do país se impõem como um caldo de cultura no qual a agressividade e a violência fincam suas raízes. Texto II - Nenhuma sociedade pode sobreviver sem canalizar as pulsões e emoções do indivíduo, sem um controle muito específico de seu comportamento. Nenhum controle desse tipo é possível sem que as pessoas anteponham limitações umas às outras, e todas as limitações são convertidas, na pessoa a quem são impostas, em medo de um ou outro tipo. Considerando-se a dinâmica do processo civilizador, tal como descrito no Texto II, o argumento do Texto I acerca da violência e agressividade na sociedade brasileira expressa a', 'dificuldade histórica da sociedade brasileira em institucionalizar formas de controle social compatíveis com valores democráticos.', 4),
    (default, 'O correr da vida embrulha tudo. A vida é assim: esquenta e esfria, aperta e daí afrouxa, sossega e depois desinquieta. O que ela quer da gente é coragem. No romance Grande sertão, o protagonista Riobaldo narra sua trajetória de jagunço. A leitura do trecho permite identificar que o desabafo de Riobaldo se aproxima de um(a)', 'aforismo, por expor uma máxima em poucas palavras.', 4),
    (default, 'Cabeludinho - Quando a Vó me recebeu nas férias, ela me apresentou aos amigos: Este é meu neto. Ele foi estudar no Rio e voltou de ateu. Ela disse que eu voltei de ateu. Aquela preposição deslocada me fantasiava de ateu. Como quem dissesse no Carnaval: aquele menino está fantasiado de palhaço. Minha avó entendia de regências verbais. Ela falava de sério. Mas todo-mundo riu. Porque aquela preposição deslocada podia fazer de uma informação um chiste. E fez. E mais: eu acho que buscar a beleza nas palavras é uma solenidade de amor. E pode ser instrumento de rir. De outra feita, no meio da pelada um menino gritou: Disilimina esse, Cabeludinho. Eu não disiliminei ninguém. Mas aquele verbo novo trouxe um perfume de poesia à nossa quadra. Aprendi nessas férias a brincar de palavras mais do que trabalhar com elas. Comecei a não gostar de palavra engavetada. Aquela que não pode mudar de lugar. Aprendi a gostar mais das palavras pelo que elas entoam do que pelo que elas informam. Por depois ouvi um vaqueiro a cantar com saudade: Ai morena, não me escreve / que eu não sei a ler. Aquele a preposto ao verbo ler, ao meu ouvir, ampliava a solidão do vaqueiro. No texto, o autor desenvolve uma reflexão sobre diferentes possibilidades de uso da língua e sobre os sentidos que esses usos podem produzir, a exemplo das expressões “voltou de ateu”, “disilimina esse” e “eu não sei a ler”. Com essa reflexão, o autor destaca', 'a valorização da dimensão lúdica e poética presente nos usos coloquiais da linguagem.', 4),
    (default, 'Abatidos pelo fadinho harmonioso e nostálgico dos desterrados, iam todos, até mesmo os brasileiros, se concentrando e caindo em tristeza; mas, de repente, o cavaquinho de Porfiro, acompanhado pelo violão do Firmo, romperam vibrantemente com um chorado baiano. Nada mais que os primeiros acordes da música crioula para que o sangue de toda aquela gente despertasse logo, como se alguém lhe fustigasse o corpo com urtigas bravas. E seguiram-se outras notas, e outras, cada vez mais ardentes e mais delirantes. Já não eram dois instrumentos que soavam, eram lúbricos gemidos e suspiros soltos em torrente, a correrem serpenteando, como cobras numa floresta incendiada; eram ais convulsos, chorados em frenesi de amor: música feita de beijos e soluços gostosos; carícia de fera, carícia de doer, fazendo estalar de gozo. No romance O Cortiço (1890), de Aluízio Azevedo, as personagens são observadas como elementos coletivos caracterizados por condicionantes de origem social, sexo e etnia. Na passagem transcrita, o confronto entre brasileiros e portugueses revela prevalência do elemento brasileiro, pois', 'mostra o poder envolvente da música brasileira, que cala o fado português.', 5),
    (default, 'O Centro-Oeste apresentou-se como extremamente receptivo aos novos fenômenos da urbanização, já que era praticamente virgem, não possuindo infraestrutura de monta, nem outros investimentos fixos vindos do passado. Pôde, assim, receber uma infraestrutura nova, totalmente a serviço de uma economia moderna. O texto trata da ocupação de uma parcela do território brasileiro. O processo econômico diretamente associado a essa ocupação foi o avanço da', 'fronteira agropecuária que degradou parte do cerrado.', 5),
    (default, 'De todas as transformações impostas pelo meio técnico-científico-informacional à logística de transportes, interessa-nos mais de perto a intermodalidade. E por uma razão muito simples: o potencial que tal “ferramenta logística” ostenta permite que haja, de fato, um sistema de transportes condizente com a escala geográfica do Brasil. A necessidade de modais de transporte interligados, no território brasileiro, justifica-se pela(s)', 'grandes distâncias e a busca da redução dos custos de transporte.', 5),
    (default, 'A soma do tempo gasto por todos os navios de carga na espera para atracar no porto de Santos é igual a 11 anos — isso, contando somente o intervalo de janeiro a outubro de 2011. O problema não foi registrado somente neste ano. Desde 2006 a perda de tempo supera uma década. A situação descrita gera consequências em cadeia, tanto para a produção quanto para o transporte. No que se refere à territorialização da produção no Brasil contemporâneo, uma dessas consequências é a', 'redução da exportação de gêneros agrícolas em função da dificuldade para o escoamento.', 6),
    (default, 'A Floresta Amazônica, com toda a sua imensidão, não vai estar aí para sempre. Foi preciso alcançar toda essa taxa de desmatamento de quase 20 mil quilômetros quadrados ao ano, na última década do século XX, para que uma pequena parcela de brasileiros se desse conta de que o maior patrimônio natural do país está sendo torrado. Um processo econômico que tem contribuído na atualidade para acelerar o problema ambiental descrito é:', 'Difusão do cultivo da soja com a implantação de monoculturas mecanizadas.', 6),
    (default, 'Por onde houve colonização portuguesa, a música popular se desenvolveu basicamente com o mesmo instrumental. Podemos ver cavaquinho e violão atuarem juntos aqui, em Cabo Verde, em Jacarta, na Indonésia, ou em Goa. O caráter nostálgico, sentimental, é outro ponto comum da música das colônias portuguesas em todo o mundo. O kronjong, a música típica de Jacarta, é uma espécie de lundu mais lento, tocado comumente com flauta, cavaquinho e violão. Em Goa não é muito diferente. De acordo com o texto de Henrique Cazes, grande parte da música popular desenvolvida nos países colonizados por Portugal compartilham um instrumental, destacando-se o cavaquinho e o violão. No Brasil, são exemplos de música popular que empregam esses mesmos instrumentos:', 'Choro e samba.', 6);

create table tb_alternativa (
    cd_alternativa BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_alternativa varchar(300),
    cd_questao BIGINT,

    constraint fk_alternativa_questao foreign key (cd_questao) references tb_questao (cd_questao)
);

insert into tb_alternativa values 
    (default, 'expectativa da investigação dos culpados.', 1),
    (default, 'punição dos torturadores da polícia.', 1),
    (default, 'violência dos terroristas de esquerda.', 1),
    (default, 'superação do governo de exceção.', 1),
    (default, 'crítica ao stalinismo.', 2),
    (default, 'combate ao fascismo.', 2),
    (default, 'rejeição ao federalismo.', 2),
    (default, 'apoio ao corporativismo.', 2),
    (default, 'Crescimento dos assentamentos rurais com mão de obra familiar – Avanço crescente das áreas rurais sobre as regiões urbanas.', 3),
    (default, 'Concentração das áreas cultiváveis no setor agroexportador – Aumento da ocupação da população pobre em territórios agrícolas marginais.', 3),
    (default, 'Desorganização da economia rural de subsistência – Crescimento do consumo interno de alimentos pelas famílias camponesas.', 3),
    (default, 'Exploração do campesinato pela elite proprietária – Domínio das instituições fundiárias pelo poder público.', 3),
    (default, 'promoção das guerras justas para conquistar o território.', 4),
    (default, 'opção pela policultura para garantir o povoamento ibérico.', 4),
    (default, 'imposição da catequese para explorar o trabalho africano.', 4),
    (default, 'fundação de cidades para controlar a circulação de riquezas.', 4),
    (default, 'valorização dos socialmente desfavorecidos.', 5),
    (default, 'implantação de governos autoritários.', 5),
    (default, 'insubordinação das tropas militares.', 5),
    (default, 'promoção da mobilização política.', 5),
    (default, 'derivam da interação entre valores africanos e a experiência histórica brasileira.', 6),
    (default, 'contribuem para o distanciamento cultural entre negros e brancos no Brasil atual.', 6),
    (default, 'demonstram a maior complexidade cultural dos africanos em relação aos europeus.', 6),
    (default, 'perderam a relação com o seu passado histórico.', 6),
    (default, 'Razões de Estado — Soberania popular.', 7),
    (default, 'Ordenação da Nação — Prerrogativas religiosas.', 7),
    (default, 'Imposição das Forças Armadas — Deveres sociais.', 7),
    (default, 'Normatização do Poder Judiciário — Regras morais.', 7),
    (default, 'o aumento da mobilidade ocupacional.', 8),
    (default, 'a redução da competitividade entre as empresas.', 8),
    (default, 'o direcionamento das vendas para os mercados regionais.', 8),
    (default, 'a ampliação do poder de planejamento dos Estados nacionais.', 8),
    (default, 'dificuldade histórica da sociedade brasileira em institucionalizar formas de controle social compatíveis com valores democráticos.', 9),
    (default, 'incapacidade das instituições político-legislativas em formular mecanismos de controle social específicos à realidade social brasileira.', 9),
    (default, 'inabilidade das forças militares em conter a violência decorrente das ondas migratórias nas grandes cidades brasileiras.', 9),
    (default, 'manutenção de práticas repressivas herdadas dos períodos ditatoriais sob a forma de leis e atos administrativos.', 9),
    (default, 'aforismo, por expor uma máxima em poucas palavras.', 10),
    (default, 'crônica, por tratar de fatos do cotidiano.', 10),
    (default, 'notícia, por informar sobre um acontecimento.', 10),
    (default, 'fábula, por apresentar uma lição de moral.', 10),
    (default, 'a valorização da dimensão lúdica e poética presente nos usos coloquiais da linguagem.', 11),
    (default, 'o relato fiel de episódios vividos por Cabeludinho durante as suas férias.', 11),
    (default, 'a distinção clara entre a norma culta e as outras variedades linguísticas.', 11),
    (default, 'a importância de certos fenômenos gramaticais para o conhecimento da língua portuguesa.', 11),
    (default, 'mostra o poder envolvente da música brasileira, que cala o fado português.', 12),
    (default, 'destaca o sentimentalismo brasileiro, contrário à tristeza dos portugueses.', 12),
    (default, 'atribui aos brasileiros uma habilidade maior com instrumentos musicais.', 12),
    (default, 'exalta a força do cenário natural brasileiro e considera o do português inexpressivo.', 12),
    (default, 'fronteira agropecuária que degradou parte do cerrado.', 13),
    (default, 'exploração mineral na Chapada dos Guimarães.', 13),
    (default, 'extrativismo na região pantaneira.', 13),
    (default, 'economia da borracha no sul da Amazônia.', 13),
    (default, 'grandes distâncias e a busca da redução dos custos de transporte.', 14),
    (default, 'formação geológica do país, que impede o uso de um único modal.', 14),
    (default, 'proximidade entre a área de produção agrícola intensiva e os portos.', 14),
    (default, 'diminuição dos fluxos materiais em detrimento de fluxos imateriais.', 14),
    (default, 'redução da exportação de gêneros agrícolas em função da dificuldade para o escoamento.', 15),
    (default, 'priorização do comércio com países vizinhos em função da existência de fronteiras terrestres.', 15),
    (default, 'estagnação da indústria de alta tecnologia em função da concentração de investimentos na infraestrutura de circulação.', 15),
    (default, 'realocação das exportações para o modal aéreo em função da rapidez.', 15),
    (default, 'Difusão do cultivo da soja com a implantação de monoculturas mecanizadas.', 16),
    (default, 'Construção da rodovia Transamazônica, com o objetivo de interligar a região Norte ao restante do país.', 16),
    (default, 'Criação de áreas extrativistas do látex das seringueiras para os chamados povos das floresta.', 16),
    (default, 'Ampliação do polo industrial da Zona Franca de Manaus, visando atrair empresas nacionais e estrangeiras.', 16),
    (default, 'Choro e samba.', 17),
    (default, 'Chula e siriri.', 17),
    (default, 'Xote e frevo.', 17),
    (default, 'Maracatu e ciranda.', 17);

create table tb_historico_teste (
    cd_historico BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    cd_nota double,
    dt_teste date,
    cd_teste BIGINT,
    cd_usuario BIGINT,

    constraint fk_historico_teste_teste foreign key (cd_teste) references tb_teste (cd_teste),
    constraint fk_historico_teste_usuario foreign key (cd_usuario) references tb_usuario (cd_usuario)
);

insert into tb_historico_teste values 
    (default, 6.4, '2018-12-01', 3, 4),
    (default, 9.0, '2018-11-28', 1, 4),
    (default, 8.8, '2018-11-25', 2, 5),
    (default, 6.9, '2018-11-25', 4, 5),
    (default, 6.6, '2018-11-25', 4, 5),
    (default, 4.8, '2018-11-25', 2, 5),
    (default, 7.5, '2018-11-25', 5, 6),
    (default, 8.0, '2018-11-25', 6, 6),
    (default, 3.1, '2018-11-25', 6, 4),
    (default, 5.2, '2018-11-25', 1, 6);

create table tb_historico_aula (
    cd_historico BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    cd_aula BIGINT,
    cd_usuario BIGINT,

    constraint fk_historico_aula_aula foreign key (cd_aula) references tb_aula (cd_aula),
    constraint fk_historico_aula_usuario foreign key (cd_usuario) references tb_usuario (cd_usuario)
);

insert into tb_historico_aula values 
    (default, 1, 4),
    (default, 1, 6),
    (default, 2, 5),
    (default, 5, 4),
    (default, 3, 4),
    (default, 6, 5),
    (default, 4, 4),
    (default, 4, 5),
    (default, 5, 6),
    (default, 3, 6);


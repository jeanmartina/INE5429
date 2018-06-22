pragma solidity ^0.4.11;

contract fundoContribuicaoDeInvalidez { //ou risco... educacional...
    
    //adicionar plano previdenciario por por aqui... ele deverá ser o owner/criador do fundo
    address participante = msg.sender; //mudar num futuro próximo
    uint public creation_time = now;
    uint public contribuition_balance = 0;
    Stages public current_stage = Stages.NOT_OPEN;
    mapping (address => uint256) contribuition_ammount; //guardar histórico de crescimento de valores
    address[] public contribuition_number;
    uint public price = 2 ether;
    
    //define estagios possiveis para o fundo de contribuicao de risco... Intenção é tirar da rede a wallet quando CLOSED (???)
    enum Stages {
        NOT_OPEN,
        WAITING_CONTRIBUITIONS,
        CLOSED
    }
    
    //modificadores para fácil verificação durante a definição de funções do contrato
    modifier onlyOwner(address account) {
        require(msg.sender == account);
        _;
    }
    
    modifier correctStage(Stages stage) {
        require(stage == current_stage);
        _;
    }
    
    //alterar para que o criador do fundo previdenciario de risco seja um plano e não participante, e só ele possa alterar...
    function iniciarFundoDeContribuicoesDeRisco() public
    onlyOwner(participante) //alterar num futuro proximo
    correctStage(Stages.NOT_OPEN) {
        current_stage = Stages.WAITING_CONTRIBUITIONS;
    }
    
    //verifica se maior ou igual ao valor estabelecido padrão de 2 ether
     modifier costs(uint _price) {
        if (msg.value >= _price) {
            _;
        }
    }
    
    //a palavra reservada payable permite que ether seja enviado ao contrato
    function () public payable
    costs(price)
    correctStage(Stages.WAITING_CONTRIBUITIONS) {
        contribuition_ammount[msg.sender] += msg.value;
        contribuition_number.push(msg.sender); // apendando no fim do array... 
        contribuition_balance += msg.value;
    }
    
    // continua nos próximos episódios
    // para finalizar o contrato, pretendo utilizar o contribuition_ballance para ver se chegou ao limite EX: X quant de ether
    
}

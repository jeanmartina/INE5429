pragma solidity ^0.4.11;

contract ContratoPrevidenciario {
    
    address owner = msg.sender;
    mapping (address => contribuicoesNormais) planoNormal;
    mapping (address => contribuicoesInvalidez) planoInvalidez;
    mapping (address => contribuicoesEducacionais) planoEducacional;
    mapping (address => Participante) participantes;
    string statusContrato; //Hot & Cold
    uint256 saldoTotalCarteira; //Deverá ter um limite de 20 ether
    uint constant defaultPrice = 1 ether; //valor padrão de contribuições
    
    struct Participante{
        uint cpf;
        uint idadeEntrada;
        uint idadeSaida;
        string statusParticipante;  //ativo, inativo e em benefício
        uint256 saldoTotalParticipante;
    }
    
    struct contribuicoesInvalidez {
        address participante;
        uint256 valor;
    }
    
    struct contribuicoesNormais {
        address participante;
        uint256 valor;
    }
    
    struct contribuicoesEducacionais {
        address participante;
        uint256 valor;
    }
    
     modifier onlyOwner(address account) {
        require(msg.sender == account);
        _;
    }
    
    //permite procurar por tal transação no futuro utilizando estes parametros indexados como filtro
     event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
     //função para comparar duas strings pelo hash, retorna true se forem diferentes
    function stringsDiferentes (string a, string b) view returns (bool){
       return keccak256(a) != keccak256(b);
   }
    
    //criação do contrato previdenciario - constructor 
    
     constructor  (uint _cpfParticipante, uint _idadeEntradaParticipante, 
    uint _idadeSaidaParticipante, address _address){
     
        var participante = participantes[_address];
     
        participante.cpf = _cpfParticipante;
        participante.idadeEntrada = _idadeSaidaParticipante;
        participante.idadeSaida = _idadeEntradaParticipante;
        participante.statusParticipante = "inativo";
        statusContrato = "hot";
        participante.saldoTotalParticipante = 0;
        saldoTotalCarteira = 0;
    }
   
    
    function realizaContribuicaoNormal (uint256 _valor) payable  {
    
        if (stringsDiferentes(statusContrato, "cold")) {
            
            if (msg.value != defaultPrice) {
                throw;
            }
            
            var novaContribuicaoNormal = planoNormal[msg.sender];
            
            novaContribuicaoNormal.valor = _valor;
            participantes[msg.sender].saldoTotalParticipante += _valor;
            saldoTotalCarteira += _valor;
            
            participantes[msg.sender].statusParticipante = "Ativo";
            
        } else {
            
            throw;      
            
        }
        
        if (saldoTotalCarteira > 20 ether) {
            statusContrato = "cold";
        }
        
    }
    
    function realizaContribuicaoInvalidez (uint256 _valor) payable  {
    
        if (stringsDiferentes(statusContrato, "cold")) {
            
            if (msg.value != defaultPrice) {
                throw;
            }
            
            var novaContribuicaoInvalidez = planoInvalidez[msg.sender];
            
            novaContribuicaoInvalidez.valor = _valor;
            participantes[msg.sender].saldoTotalParticipante += _valor;
            saldoTotalCarteira += _valor;
            
        } else {
            
            throw;      
            
        }
        
        if (saldoTotalCarteira > 20 ether) {
            statusContrato = "cold";
        }
        
    }
    
    function realizaContribuicaoEducacional (uint256 _valor) payable  {
    
        if (stringsDiferentes(statusContrato, "cold")) {
            
            if (msg.value != defaultPrice) {
                throw;
            }
            
            var novaContribuicaoEducacional = planoEducacional[msg.sender];
            
            novaContribuicaoEducacional.valor = _valor;
            participantes[msg.sender].saldoTotalParticipante += _valor;
            saldoTotalCarteira += _valor;
            
        } else {
            
            throw;      
            
        }
        
        if (saldoTotalCarteira > 20 ether) {
            statusContrato = "cold";
        }
        
    }
    
    
     function realizaResgateIntegral () payable{
         
        uint256 valorPagar = participantes[msg.sender].saldoTotalParticipante;
        if (valorPagar <= 0 ) {
            throw;
        }
        msg.sender.call.value(valorPagar).gas(20317)();
        
        planoEducacional[msg.sender].valor = 0;
        planoInvalidez[msg.sender].valor = 0;
        planoNormal[msg.sender].valor = 0;
        saldoTotalCarteira -= valorPagar;
        participantes[msg.sender].saldoTotalParticipante = 0;
        
        setStatusParticipante(msg.sender, "Em benefício");
        
    }
    
    
     
     function getStatusContrato () returns (string ) {
            statusContrato;
    }
    
    //para tornar hot/cold uma carteira, somente o owner pode alterar seu status
     function setStatusContrato (string _newStatus) onlyOwner(owner) {
            statusContrato = _newStatus;
     }
    
     function getOwner () returns (address ) {
            owner;
    }
    
    function getSaldoParticipante () returns (uint) {
            participantes[msg.sender].saldoTotalParticipante; 
    }
    
    function setStatusParticipante (address _address, string _novoStatus) onlyOwner(owner) {
            participantes[_address].statusParticipante = _novoStatus;
    }
    
}

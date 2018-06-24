pragma solidity ^0.4.11;

contract ContratoPrevidenciario {
    
    address owner = msg.sender;
    mapping (address => contribuicoesNormais) planoNormal;
    //mapping (address => contribuicoesInvalidez) planoInvalidez;
    //mapping (address => contribuicoesEducacionais) planoEducacional;
    mapping (address => Participante) participantes;
    string statusContrato;
    uint256 saldoTotalCarteira;
    
    struct Participante{
        uint cpf;
        uint idadeEntrada;
        uint idadeSaida;
        string statusParticipante;
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
        participante.statusParticipante = "ativo";
        statusContrato = "hot";
        participante.saldoTotalParticipante = 0;
        saldoTotalCarteira = 0;
    }
   
    
    function realizaContribuicaoNormal (uint256 _valor) payable  {
    
        if (stringsDiferentes(statusContrato, "cold")) {
            
            var novaContribuicaoNormal = planoNormal[msg.sender];
            
            novaContribuicaoNormal.valor = _valor;
            participantes[msg.sender].saldoTotalParticipante += _valor;
            saldoTotalCarteira += _valor;
            
        } else {
            
            return;        
            
        }
        
        if (saldoTotalCarteira > 20 ether) {
            statusContrato = "cold";
        }
        
    }
    
     function realizaResgate () public onlyOwner(owner) {
        uint256 valorPagar = participantes[msg.sender].saldoTotalParticipante;
        address enderecoWallerParticipante = msg.sender;
        //msg.sender.call.gas(valorpagar);

    }
    
    
     
     function getStatusContrato () returns (string ) {
            statusContrato;
    }
    
     function setStatusContrato (string _newStatus) onlyOwner(owner) {
            statusContrato = _newStatus;
     }
    
     function getOwner () returns (address ) {
            owner;
    }
}

. C:\Scripts\Search-User.ps1

<# Autor: Maxwell Gomes da Silva
GitHub: https://github.com/MaxwellGomes777

Descrição: Esse script junto do script "Search-User" localiza os usuários do AD pelo Login de Rede ou pelo CPF mostrando e-mail, ultimo logon,
CPF ou Login de rede e data da criação.

OBS¹: O CPF pode ser inserido com ou sem as pontuações, o sistema vai remover e buscar o CPF sem pontuações.

OBS²: Extension Attribute estava sendo utilizado como campo para inserir os CPFs no AD, mudar no Search-User para o campo
utilizado na sua empresa
#>

function Trata-Cpf {
param (
[string]$InfoCpf
)
$cpfnovo = $InfoCpf.ToLower().Replace(".", " ").Replace("-", " ").Replace(",", " ").Replace(" ", "")
$cpfnovo

} #Função para tratar CPF com pontuação para sem pontuação 
while ($true){
Clear
$escolha = Read-Host "Digite 1 para CPF e 2 para Login"

$escolhacpf
If ( $escolha -eq "1"){
$cpf_ = Read-Host -prompt "Digite o CPF"
$cpf = Trata-Cpf $cpf_ #tratando o cpf
$criado = Search-User CPF $cpf -OutputType whenCreated
$login = Search-User CPF $cpf -OutputType samaccount
$ultimologon = Search-User CPF $cpf -OutputType LastLogonDate
$email = Search-User CPF $cpf -OutputType email
Write-Host "Login de rede:" $login "| Criado em:" $criado "| Ultimo login:" $ultimologon "| Email:" $email
} else {
$lrede = Read-Host -prompt "Digite o Login"
$criado = Search-User samaccount $lrede -OutputType whenCreated
$cpf = Search-User samaccount $lrede -OutputType cpf
$ultimologon = Search-User samaccount $lrede -OutputType LastLogonDate
$email = Search-User samaccount $lrede -OutputType email
Write-Host "CPF:" $cpf "| Criado em:" $criado "| Ultimo login:" $ultimologon "| Email:" $email  $active
} #caso seja consulta por Login de rede
read-host -prompt "Tecle ENTER para continuar ou CTRL+C para sair"
} #repetição (while) para novas consultas






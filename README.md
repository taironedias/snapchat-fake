### snapchat-fake for iOS
Creating a snapchat fake app for iOS learning.

Abaixo apresentamos algumas telas do desenvolvimento realizado. Algumas regras de negócio necessária para o funcionamento correto de app semelhante ao Snapchat, não foram consideradas. O objetivo desse desenvolvimento, foi para o aprendizado. Reforçando assim o conhecimento e interação com Firebase, permissões de acesso ao álbum de fotos, UITableViewController, entre outros.

##### # Tela inicial > Tela de cadastro > Tela de login
<table>
  <tr>
    <th> 
        <img src="/prints/telainicial.png" width="250" height="445">
    <th>
        <img src="/prints/telacadastro.png" width="250" height="445">
    </th>
    <th>
        <img src="/prints/telalogin.png" width="250" height="445">
    </th>
  </tr>
</table>


##### # App do usuário 1
Essa é a tela que aparecerá os snaps enviado por outros usuários. Para enviar um snap, o usuário deve tocar no botão "+" no qual redirecionará para a outra tela (mostrada abaixo ao lado da tela principal). Nessa tela de Fotos, o usuário pode selecionar a foto, adicionar uma descrição e clicar em próximo para fazer upload da imagem.

<table>
  <tr>
    <th> 
        <img src="/prints/telaprincipal.png" width="250" height="445"> </th>
    <th>
        <img src="/prints/telafoto.png" width="250" height="445">
    </th>
  </tr>
</table>

Ao fazer upload da imagem o sisteam redireciona para a tela de listagem de usuários, e ao selecionar um usuário específico o sistema envia o snap e retorna para a tela principal

<img src="/prints/telasendfoto.png" width="250" height="445">


##### # App do usuário 2
No segundo usuário, assim que alguém envia um snap para ele aparecerá o nome do usuário que o enviou. E ao clicar, o sistema realizará o download da imagem.
<table>
  <tr>
    <th> 
        <img src="/prints/telauser2.png" width="250" height="445">
    <th>
        <img src="/prints/telaopensnap.png" width="250" height="445">
    </th>
  </tr>
</table>

Após o download da imagem o usuário 2 terá apenas 10 segundos para visualizar a imagem e ler a descrição. Após, esse procedimento o sistema apaga a imagem no Firebase e retorna para a tela principal.
<table>
  <tr>
    <th> 
        <img src="/prints/telasnap.png" width="250" height="445">
    <th>
        <img src="/prints/telaprincipal2.png" width="250" height="445">
    </th>
  </tr>
</table>


Esse foi um projeto desenvolvido para fins de estudo e prática da linguagem e componentes do Swift para iOS.
=)

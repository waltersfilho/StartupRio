class ComentariosController < ApplicationController
  before_action :set_publicacao, only: [:create, :destroy, :upvote, :downvote]
  before_action :authenticate_user!
  before_filter :require_permission, only: [:destroy, :upvote, :downvote]

  def upvote
    @comentario.upvote_by current_user
    redirect_to :back
  end
  def downvote
    @comentario.downvote_from current_user
    redirect_to :back
  end
  def require_permission
    set_post
    @comentario = @publicacao.comentarios.find(params[:id])
    if (current_user != @publicacao.user) and (current_user != @comentario.user)
      flash[:notice] = 'Permissões insuficientes!'
      redirect_to @publicacao
    end
  end
  def create
    #@publicacao = Publicacao.find(params[:publicacao_id])
    #Construção de um comentário dentro do post.
    @comentario = @publicacao.comentarios.build(comentario_params)
    @comentario.user_id = current_user.id
    @comentario.save
    redirect_to @publicacao


  end
  def destroy
    #Encontrando um comentário dentro do post.
    @comentario = @publicacao.comentarios.find(params[:id])
    @comentario.destroy
    redirect_to @publicacao
  end
  private
  def require_permission
    set_publicacao
    @comentario = @publicacao.comentarios.find(params[:id])
    if (current_user != @publicacao.user) and (current_user != @comentario.user)
      flash[:notice] = 'Permissões insuficientes!'
      redirect_to @publicacao
    end
  end

  def set_publicacao
    @publicacao = Publicacao.find(params[:publicacao_id])
  end
  #agora não precisamos mais do post_id. Ele é preenchido automaticamente.
  def comentario_params
    params.require(:comentario).permit(:mensagem)
  end
end
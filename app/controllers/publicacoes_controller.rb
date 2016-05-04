class PublicacoesController < ApplicationController
  before_action :set_publicacao, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:show, :index, :upvote, :downvote]
  #Garantindo que somente o dono de um Post pode executar as ações de edit, update e destroy
  before_filter :require_permission, only: [:edit, :update, :destroy, :upvote, :downvote]
  # GET /posts
  # GET /posts.json

  def index
    @publicacoes = Publicacao.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end
  # GET /posts/new
  def new
    #Cria post já associado ao usuário
    @publicacao = current_user.publicacoes.build
  end
  # GET /posts/1/edit
  def edit
  end
  # POST /posts
  # POST /posts.json
  def create
    #Cria post já associado ao usuário
    @publicacao = current_user.publicacoes.build(publicacao_params)
    respond_to do |format|
      if @publicacao.save
        format.html { redirect_to publicacoes_path, notice: 'Post criado com sucesso.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @publicacao.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @publicacao.update(post_params)
        format.html { redirect_to @publicacao, notice: 'Post atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @publicacao.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @publicacao.destroy
    respond_to do |format|
      format.html { redirect_to publicacoes_url, notice: 'Post apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @publicacao.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @publicacao.downvote_from current_user
    redirect_to :back
  end

  private
  def require_permission
    if current_user != Publicacao.find(params[:id]).user
      flash[:notice] = 'Permissões insuficientes!'
      redirect_to root_path
    end
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_publicacao
    @publicacao = Publicacao.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def publicacao_params
    params.require(:publicacao).permit(:titulo, :corpo)
  end
end
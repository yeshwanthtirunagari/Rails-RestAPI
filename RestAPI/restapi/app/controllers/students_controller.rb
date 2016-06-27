class StudentsController < ApplicationController

  def index
    @students = Student.all
    render :json => @students
  end

  def show
    @student = Student.find(params[:id])
    render :json => @student
  end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.json { render json: @student, status: :created, location: @student }
      else
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @student = Student.find(params[:id])
    respond_to do |format|
      if @student.update(student_params)
        format.json { render :show, status: :ok, location: @student }
      else
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    respond_to do |format|
      format.json { render json: {success: true, msg: 'student deleted successfully'} }
     
    end
  end

  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :age, :gender)
    end
end

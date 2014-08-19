class StudentsController < ApplicationController

	def new
		@student=Student.new
	end

	def create
		@student=Student.new(user_params)
		if @student.save
		flash[:success]="Successfully saved" 
		redirect_to students_path
	    else
	    render "new"
	    end
	   
	end

	def edit
		@student=Student.find(params[:id])
	end

	def update
		@student=Student.find(params[:id])
		if  @student.update_attributes(user_params)
			flash[:success]="Successfully updated"
			redirect_to students_path
		else
			render edit
		end
	end

	def destroy
		@student=Student.find(params[:id])
		@student.destroy
		flash[:success]="Successfully deleted"
		redirect_to students_path
	end

	def index
		@student=Student.all
	end

	def search
		if !params[:commit].nil?
			@name=params[:name] if !params[:name].nil?
			@age=params[:age] if !params[:age].nil?
			@gender=params[:gender] if !params[:gender].nil?
			@standard=params[:standard] if !params[:standard].nil?
			var=[]
			var << ["std_name"=>@name] <<["age"=> @age] <<["gender"=> @gender] <<["standard"=>@standard]
			arr=var.flatten.inject(&:merge)
			str=''
			arr.each do |k,v|
				unless v==""
					str= k + "=" + "'#{v}'" + " and " + str
				end
			end
			str=str.split(' ')[0...-1].join(' ')
			@student=Student.where(str)	
			# var = "std_name LIKE " + @name +" and " + " age in " + @age  +" and " + " gender LIKE " + @gender
			# @stu=Student.where()
			# # @stu=Student.find_by_sql [
			# # 	"select id from students where std_name in (?) 
			# # 	union 
			# # 	select id from students where age in (?)
			# #     union 
			# #     select id from students where standard in (?) 
			# #     union 
			# #     select id from students where gender in (?);","#{params[:name]}","#{params[:age]}","#{params[:standard]}","#{params[:gender]}"]
		 # #    @stu2=Student.find_all_by_id(@stu)
		 # #    # p @stu2
		 #    # p @stu2
		 #    # p @stu2
		 #    # p "%%%%%%%%%%%%%%%"
		 #    # @student=@stu2.find_by_std_name_and_age(params[:name],params[:age])
			# #@student=@stu2.find(var)
			# 	#std_name LIKE in (?) :gender LIKE in (?)","%#{@name}%","%#{@gender}%"
			# 	#@gender,:age=>@age,:standard=>@standard})
			# # p "%%%%%%%%%%%%%%%"
			# # p "%%%%%%%%%%%%%%%"
			# # p @student
   #          # p @name
   #          # p @age
   #          # p @gender
   #          # p @standard
			# # "select distinct s.id from 
			# # (select * from students where std_name like %#{params[:name]}%) as s,
			# # (select * from students where age=#{params[:age]}) as s1, 
			# # (select * from students where standard like %#{params[:standard]}%) as s2,
			# # (select * from students where gender like %#{params[:gender]}%) as s3 
			# # where s.id=s1.id or s2.id=s1.id or s2.id=s3.id or s3.id=s1.id;"
			# #@student=ActiveRecord::Base.connection.execute(@sql)
			# #Student.where('std_name LIKE :name OR age =:age' ,{:name=>"%#{params[:name]}%" ,:age=>"#{params[:age]}"}) #or 'age LIKE ?' or 'gender LIKE ?' or 'standard LIKE ?'
			  @back=search_path
			render 'search_data'
		end
			#,"%#{params[:age]}%","%#{params[:gender]}%","%#{params[:standard]}%"		
	end
	def search_data
      
	end
	private
	def user_params
    	params.require(:student).permit(:std_name,:age,:gender,:standard,:father_name,:mother_name,:address)
    end
end

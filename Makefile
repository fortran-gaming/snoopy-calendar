
snpcal: snppic.f snpcal.f
	$(FC) -g $^ -o $@
	
clean:
	$(RM) snpcal
	
test:
	./snpcal 2018
	@diff 	snpcal2018.txt ref/snpcal2018.txt 
	@echo OK

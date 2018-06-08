
snpcal: snppic.f snpcal.f
	$(FC) -g $^ -o $@
	
clean:
	$(RM) snpcal

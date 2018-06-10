
snpcal: snppic.f90 snpcal.f
	$(FC) -g $^ -o $@

clean:
	$(RM) snpcal

test:
	@./snpcal 2018 | diff --text -a - ref/snpcal2018.txt
	@echo OK

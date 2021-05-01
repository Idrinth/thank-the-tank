<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="ThankTheTank" version="1.0.0" date="2021-04-21" >
    <VersionSettings gameVersion="1.4.8" windowsVersion="1.40" savedVariablesVersion="1.50" />

		<Author name="Idrinth"/>

		<Description text="Tracks guard and allows for easier thank yous to tanks guarding" />
		<Dependencies>
			<Dependency name="LibGuard"/>
		</Dependencies>
		<Files>
			<File name="window.xml" />
            <File name="thank-the-tank.lua" />
		</Files>
		<OnInitialize>
            <CallFunction name="ThankTheTank.OnInitialize" />
		</OnInitialize>
		<OnUpdate>
		</OnUpdate>
		<SavedVariables>
		</SavedVariables>
		<WARInfo>
			<Categories>
				<Category name="OTHER"/>
			</Categories>
		</WARInfo>

	</UiMod>
</ModuleFile>
